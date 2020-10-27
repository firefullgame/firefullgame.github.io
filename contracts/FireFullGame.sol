pragma solidity ^0.5.3;

contract Ownable {
  mapping(address => bool) public owners;
  address public creater;
  constructor() public {
    owners[msg.sender] = true;
    creater = msg.sender;
  }
  modifier onlyOwner() {
    require(owners[msg.sender] == true,'Permission denied');
    _;
  }
  modifier onlyCreater() {
    require(creater == msg.sender,'Permission denied');
    _;
  }
  function addOwnership(address _newOwner) public onlyOwner {
    owners[_newOwner] = true;
  }
  function delOwnership(address _newOwner) public onlyOwner {
    owners[_newOwner] = false;
  }
}
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint _a, uint _b) internal pure returns (uint c) {
    // Gas optimization: this is cheaper than asserting 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
    if (_a == 0) {
      return 0;
    }

    c = _a * _b;
    require(c / _a == _b,'mul error');
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint _a, uint _b) internal pure returns (uint) {
    // assert(_b > 0); // Solidity automatically throws when dividing by 0
    // uint c = _a / _b;
    // assert(_a == _b * c + _a % _b); // There is no case in which this doesn't hold
    return _a / _b;
  }

  /**
  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint _a, uint _b) internal pure returns (uint) {
    require(_b <= _a,'sub error');
    return _a - _b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint _a, uint _b) internal pure returns (uint c) {
    c = _a + _b;
    require(c >= _a,'add error');
    return c;
  }
}

interface FirePowerToken {
    function saleScale() external view returns (uint);
    function superNode() external view returns (address[] memory) ;
    function balanceOf(address _owner) external view returns (uint) ;
    function burn(address _from, uint _value) external returns (bool);
    function totalSupply() external view returns (uint);
}
contract FFGModel{
    struct playerObj{
        bool state;
        bool joinState;
        uint input;
        uint output;
        uint nomalMax;
        uint totalProfit;
        uint nomalProfit;
        uint teamProfit;
        uint gameBalance;
        address[] invit;
        uint[] recommand;
        uint reserve;
        uint teamJoin;
        bool isNode;
    }
    
    struct jackpotObj{
        uint pool;
        uint water;
        uint scale;
    }
    struct superNodeObj{
        bool isActive;
        uint profit;
        uint profitFlag;
    }
}
contract FFGConfig is FFGModel{
    address public firePowerContract = 0xD0F8eB83a6917092f37CfC5ae3c9eaD3624854fd;
    FirePowerToken internal token = FirePowerToken(firePowerContract);
    uint public periods = 1;
    uint public totalJoin = 0;
    uint public sedimentaryAsset = 0;
    uint public playerCounter = 0;
    uint public minJoinAmount = 2000 trx;
    
    mapping(address => playerObj) public players;
    mapping(uint => address) public joinPlayerList;
    address[] public nomalList = new address[](5);
    uint public nomalListIndex = 0;
    bool public gameState = false;
    event WithdrawEvent(address indexed _player,uint _amount,uint time);
    event InvitEvent(address indexed _from,address _player,uint time);
    event JoinEvent(address indexed _player,uint _joinAmount,uint time);
    event ProfitEvent(address indexed _player,uint _rewardAmount,uint time);
    event TeamRewardEvent(address indexed _player,address _invit,uint _level, uint _rewardAmount,uint time);
    event PrizeEvent(address indexed _player,uint _jackpot,uint _prize,uint _amount,uint time);
    event SuperNodeEvent(address indexed _player,uint _total,uint _amount,uint time);
    event leaveGameEvent(address indexed _player,uint _output,uint time);
    uint[] public rewardScale = new uint[](10);
    uint public jackpotIndex = 1;
    mapping(uint=>jackpotObj) public jackpot;
    uint public retainScale = 3;
    uint public retainFlag = 0;
    mapping(address => superNodeObj) public superNodeList;

    function periodsLimit() public view returns(uint){
        if(periods == 1){
            return 50000 trx;
        }else if(periods == 2){
            return 100000 trx;
        }else{
            return 200000 trx;
        }
    }
    function joinScale() public view returns(uint){
        if(periods == 1){
            return 26;
        }else if(periods == 2){
            return 30;
        }else{
            return 36;
        }
    }
    /*function joinScale(uint _amount) internal pure returns (uint){
        if(_amount >= 2000 trx && _amount <= 50000 trx){
            return 26;
        }else if(_amount > 50000 trx && _amount<= 100000 trx){
            return 30;
        }else if(_amount > 100000 trx && _amount<= 200000 trx){
            return 36;
        }else{
            return 0;
        }
    }*/
    modifier isHuman() {
        address _addr = msg.sender;
        uint _codeLength;
        
        assembly {_codeLength := extcodesize(_addr)}
        require(_codeLength == 0, "sorry humans only");
        _;
    }
}

contract FireFullGame is FFGConfig,Ownable{
    using SafeMath for uint;
    function join() payable external{
        require(gameState,'Game Not Start');
        require(msg.value <= periodsLimit(),'Period Maxmum limit exceeded');
        require(msg.value >= minJoinAmount,'Period Minimum limit exceeded');
        require(players[msg.sender].state,'Please bind the recommender in advance');
        
        uint scale = joinScale();
        uint profit = msg.value.mul(scale).div(10);
        uint ticketScale = token.saleScale();
        uint ticket = msg.value.mul(100).div(ticketScale);
        uint tokenBalance = token.balanceOf(msg.sender);
        require(tokenBalance >= ticket,'ticket not enough');
        
        gameReward(msg.value.mul(35).div(100));
        
        
        joinPlayerList[playerCounter] = msg.sender;
        playerCounter = playerCounter + 1;
        
        
        totalJoin = totalJoin.add(msg.value);
        
        if(nomalListIndex < 5){
            nomalList[nomalListIndex] = msg.sender;
            nomalListIndex++;
        }
        
        /*if(players[msg.sender].state == false){
            address[] memory myinvit = new address[](10);
            myinvit[0] = _invit;
            players[_invit].recommand[0]+=1;
            players[_invit].recommand[1]+=1;
            for(uint i = 0;i<9;i++){
                if(players[_invit].invit[i]!=address(0x0)){
                    myinvit[i+2] = players[_invit].invit[i];
                    players[players[_invit].invit[i]].recommand[i+2]+=1;
                }else{
                    break;
                }
            }
            
            emit InvitEvent(_invit,msg.sender,now);

            address[] memory nodeList = token.superNode();
            bool nodeFlag = false;
            for(uint ii = 0; ii<nodeList.length;ii++){
                if(nodeList[ii] == msg.sender){
                    nodeFlag = true;
                    superNodeList[msg.sender] = superNodeObj({
                        isActive:nodeFlag,
                        profit:0,
                        profitFlag:0
                    });
                    break;
                }
            }

            players[msg.sender] = playerObj({
                state:true,
                joinState:true,
                input:msg.value, 
                nomalMax:msg.value.mul(11).div(10),
                output:profit,
                totalProfit:0,
                nomalProfit:0,
                teamProfit:0,
                gameBalance:0,
                invit:myinvit,
                recommand:new uint[](11),
                reserve:0,
                teamJoin:0,
                isNode:nodeFlag
            });
            
            
        }else{
            playerObj memory player = players[msg.sender];
            if(player.joinState == true){
                if(player.input.add(msg.value) > periodsLimit()){
                    player.reserve = player.reserve.add(msg.value);
                }else{
                    player.input = player.input.add(msg.value);
                    uint _scale = joinScale(player.input);
                    player.output = player.input.mul(_scale).div(10);
                    player.nomalMax = player.input.mul(11).div(10);
                }
            }else{
                player.input = msg.value;
                player.output = profit;
                player.totalProfit = 0;
                player.nomalProfit = 0;
                player.teamProfit = 0;
                player.joinState = true;
                players[_invit].recommand[0]+=1;
            }
            players[msg.sender] = player;
        }*/
        playerObj memory player = players[msg.sender];
        if(player.joinState == true){
            if(player.input.add(msg.value) > periodsLimit()){
                player.reserve = player.reserve.add(msg.value);
            }else{
                player.input = player.input.add(msg.value);
                uint _scale = joinScale();
                player.output = player.input.mul(_scale).div(10);
                player.nomalMax = player.input.mul(11).div(10);
            }
        }else{
            player.input = msg.value;
            player.output = profit;
            player.totalProfit = 0;
            player.nomalProfit = 0;
            player.teamProfit = 0;
            player.joinState = true;
            player.nomalMax = msg.value.mul(11).div(10);
            players[player.invit[0]].recommand[0]+=1;
        }
        players[msg.sender] = player;
        teamReward();
        joinJackpot();
        token.burn(msg.sender,ticket);
        emit JoinEvent(msg.sender,msg.value,now);
    }
    function setFirePowerContract(address _firePowerContract) external onlyOwner returns(bool){
        firePowerContract = _firePowerContract;
        token = FirePowerToken(firePowerContract);
        return true;
    }
    function setMinJoinAmount(uint _amount) external onlyOwner returns (bool){
        minJoinAmount = _amount;
        return true;
    }
    function withdraw() external isHuman{
        uint balance = players[msg.sender].gameBalance;
        players[msg.sender].gameBalance = 0;
        msg.sender.transfer(balance);
        emit WithdrawEvent(msg.sender,balance,now);
    }
    function retainWithdraw() external onlyOwner{
        require(totalJoin != retainFlag,'retain amount not enoug');
        uint amount = totalJoin.sub(retainFlag).mul(retainScale).div(100);
        msg.sender.call.value(amount)("");
        retainFlag = totalJoin;
        emit WithdrawEvent(msg.sender,amount,now);
    }
    function sedimentaryAssetWithdraw(uint _amount) external onlyOwner{
        require(sedimentaryAsset >= _amount,'sedimentary asset not enoug');
        msg.sender.call.value(_amount)("");
        sedimentaryAsset = sedimentaryAsset.sub(_amount);
        emit WithdrawEvent(msg.sender,sedimentaryAsset,now);
    }
    function gameReward(uint _amount) internal {
        uint maxPlayer = nomalListIndex < 5?nomalListIndex:5;
        uint reward = _amount;
        if(maxPlayer == 0){
            sedimentaryAsset = sedimentaryAsset.add(reward);
            return;
        }
        reward = reward.div(maxPlayer);
        address player_add;
        playerObj memory player;
        uint _reward;
        bool haveNext = true;
        uint surplus = 0;
        uint player_reward = 0;
        bool leave;
        for(uint i = 0;i<maxPlayer;i++){
            player_add = nomalList[i];
            if(haveNext && player_add == address(0x0)){
                findNextNomal(i);
                if(nomalList[i] == address(0x0)){
                    haveNext = false;
                    surplus = surplus.add(reward);
                    continue;
                }else{
                    player_add = nomalList[i];
                }
            }
            surplus = reward.add(surplus);
            _reward = surplus;
            do{
                player = players[player_add];
                
                player_reward = surplus;
                surplus = 0;
                if(player.nomalProfit.add(player_reward) >= player.nomalMax){
                    player_reward = player.nomalMax - player.nomalProfit;
                    player.nomalProfit = player.nomalMax;
                    leave = true;
                }else{
                    player.nomalProfit = player.nomalProfit.add(player_reward);
                }
                if(player.totalProfit.add(player_reward) >= player.output){
                    player_reward = player.output - player.totalProfit;
                    player.totalProfit = player.output;
                    leave = true;
                    leaveGame(player,player_add,true);
                }else{
                    player.totalProfit = player.totalProfit.add(player_reward);
                }
                if(player_reward > 0){
                    player.gameBalance = player.gameBalance.add(player_reward);
                    players[player_add] = player;
                    emit ProfitEvent(player_add,player_reward,now);
                }
                if(leave){
                    if(_reward.sub(player_reward) > 0){
                        surplus = _reward.sub(player_reward);
                    }else{
                        break;
                    }
                    if(haveNext){
                        findNextNomal(i);
                        if(nomalList[i] == address(0x0)){
                            haveNext = false;
                            break;
                        }else{
                            player_add = nomalList[i];
                        }
                    }else{
                        break;
                    }
                }else{
                    break;
                }
            }while(true);
        }
        if(surplus > 0){
            sedimentaryAsset = sedimentaryAsset.add(surplus);
        }
    }
    function findNextNomal(uint nomalIndex) internal{
        address next;
        uint index = nomalListIndex;
        do{
            next = joinPlayerList[index];
            index++;
            if(index > playerCounter){
                index = nomalListIndex;
                break;
            }
        }while(players[next].joinState == false);
        nomalList[nomalIndex] = next;
        nomalListIndex = index;
    }
    function teamReward() internal{
        address[] memory myInvit = players[msg.sender].invit;
        uint reward;
        uint needRecommand;
        uint split;
        playerObj memory invitPlayer;
        for(uint i = 0;i < myInvit.length;i++){
            invitPlayer = players[myInvit[i]];
            reward = msg.value.mul(rewardScale[i]).div(100);
            if(myInvit[i] == address(0x0) || invitPlayer.joinState == false){
                sedimentaryAsset = sedimentaryAsset.add(reward);
                continue;
            }
            invitPlayer.teamJoin = invitPlayer.teamJoin.add(msg.value);
            needRecommand = (i+1)/2 + (i+1)%2;
            if(invitPlayer.recommand[0] >= needRecommand && invitPlayer.joinState == true){
                invitPlayer.totalProfit = invitPlayer.totalProfit.add(reward);
                if(invitPlayer.totalProfit > invitPlayer.output){
                    split = invitPlayer.totalProfit.sub(invitPlayer.output);
                    reward = reward.sub(split);
                     if(split > 0){
                        sedimentaryAsset = sedimentaryAsset.add(split);
                    }
                    invitPlayer.totalProfit = invitPlayer.output;
                }
                invitPlayer.teamProfit = invitPlayer.teamProfit.add(reward);
                invitPlayer.gameBalance = invitPlayer.gameBalance.add(reward);
                emit TeamRewardEvent(myInvit[i],msg.sender,i+1, reward,now);
            }else{
                sedimentaryAsset = sedimentaryAsset.add(reward);
            }
            players[myInvit[i]] = invitPlayer;
            if(invitPlayer.totalProfit == invitPlayer.output){
                leaveGame(invitPlayer,myInvit[i],true);
            }
        }
    }
    function leaveGame(playerObj memory player,address _player,bool find) internal{
        if(player.totalProfit >= player.output && player.joinState == true){
            emit leaveGameEvent(_player,player.totalProfit,now);
            if(find){
                for(uint k = 0; k<5;k++){
                    if(nomalList[k] == _player){
                        findNextNomal(k);
                    }
                }
            }
            if(player.reserve > 0){
                uint limit = periodsLimit();
                uint reInput = 0;
                if(player.reserve > limit){
                    player.reserve = player.reserve.sub(limit);
                    reInput = limit;
                }else{
                    reInput = player.reserve;
                    player.reserve = 0;
                }
                uint scale = joinScale();
                player.input = reInput;
                player.output = reInput.mul(scale).div(10);
                player.nomalMax = reInput.mul(11).div(10);
                player.totalProfit = 0;
                player.nomalProfit = 0;
                player.teamProfit = 0;
            }else{
                player.joinState = false;
                if(player.invit[0] != address(0x0)){
                    players[player.invit[0]].recommand[0] -= 1;
                }
            }
            players[_player] = player;
            
        }
    }
    function joinJackpot() internal{
        uint input = msg.value.mul(15).div(100);
        if(jackpot[jackpotIndex].water.add(input) >= jackpot[jackpotIndex].pool){
            if(jackpot[jackpotIndex].water.add(input) > jackpot[jackpotIndex].pool){
                
                uint split = jackpot[jackpotIndex].water.add(input).sub(jackpot[jackpotIndex].pool);
                jackpot[jackpotIndex].water = jackpot[jackpotIndex].pool;
                drawJackpot(split);
            }else{
                jackpot[jackpotIndex].water = jackpot[jackpotIndex].pool;
                drawJackpot(0);
            }
            
        }else{
            jackpot[jackpotIndex].water = jackpot[jackpotIndex].water.add(input);
        }
    }
    function nextJackpot() internal view returns(uint){
        if(jackpotIndex < 5){
            return jackpotIndex + 1;
        }else{
            return 1;
        }
    }
    function drawJackpot(uint surplus) internal{
        if(jackpot[jackpotIndex].water == jackpot[jackpotIndex].pool){
            uint reward = jackpot[jackpotIndex].water.mul(jackpot[jackpotIndex].scale).div(100);
            uint index = 1;
            uint _reward = 0;
            uint _prize = 0;
            playerObj memory player;
            for(uint i = playerCounter-1;i >= playerCounter.sub(32);i--){
                if(index == 1){
                    _reward = reward.mul(45).div(100);
                    _prize = 1;
                }else if(index > 1 && index <= 11){
                    _reward = reward.mul(20).div(1000);
                    _prize = 2;
                }else if(index > 11 && index <= 31){
                    _reward = reward.mul(35).div(2000);
                    _prize = 3;
                }else{
                    break;
                }
                player = players[joinPlayerList[i]];
                player.gameBalance = player.gameBalance.add(_reward);
                if(player.totalProfit.add(_reward) >= player.output){
                    player.totalProfit = player.output;
                }else{
                    player.totalProfit = player.totalProfit.add(_reward);
                }
                players[joinPlayerList[i]] = player;
                leaveGame(player,joinPlayerList[i],true);
                emit PrizeEvent(joinPlayerList[i],jackpot[jackpotIndex].pool,_prize,_reward,now);
                index++;
            }

            uint split = jackpot[jackpotIndex].water.sub(reward);
            jackpotIndex = nextJackpot();
            if(jackpotIndex == 1){
                initJackpot();
            }
            jackpot[jackpotIndex].water = split.add(surplus);
        }
        //require(jackpot[jackpotIndex].water == jackpot[jackpotIndex].pool,'jackpot error');
        
    }
    function superNodeWithdraw() external isHuman{ 
        require(players[msg.sender].isNode,"You're not a super node");
        require(superNodeList[msg.sender].isActive,"You haven't activated the super node yet");
        uint flag = totalJoin.sub(superNodeList[msg.sender].profitFlag);
        require(flag > 1,"You don't have any new profit yet");
        superNodeList[msg.sender].profitFlag = totalJoin;
        uint profit = flag.mul(5).div(10000);
        superNodeList[msg.sender].profit = superNodeList[msg.sender].profit.add(profit);
        msg.sender.transfer(profit);
        emit SuperNodeEvent(msg.sender,flag,profit,now);
    }
    
    function superNodeProfit() external view returns(uint){
        uint flag = totalJoin.sub(superNodeList[msg.sender].profitFlag);
        return flag.mul(5).div(10000);
    }

    function initJackpot() internal{
        jackpot[1] = jackpotObj({pool:1500000 trx,water:0,scale:60});
        jackpot[2] = jackpotObj({pool:3000000 trx,water:0,scale:60});
        jackpot[3] = jackpotObj({pool:4500000 trx,water:0,scale:60});
        jackpot[4] = jackpotObj({pool:6000000 trx,water:0,scale:60});
        jackpot[5] = jackpotObj({pool:7500000 trx,water:0,scale:90});
    }

    function startGame() external {
        require(msg.sender == firePowerContract,'startGame error');
        if(!gameState){
            gameState = true;
        }
    }

    function activateSuperNode() external{
        require(players[msg.sender].isNode == false,'SuperNode Activated');
        address[] memory nodeList = token.superNode();
        bool nodeFlag = false;
        for(uint ii = 0; ii<nodeList.length;ii++){
            if(nodeList[ii] == msg.sender){
                nodeFlag = true;
                superNodeList[msg.sender] = superNodeObj({
                    isActive:nodeFlag,
                    profit:0,
                    profitFlag:0
                });
                break;
            }
        }
        if(nodeFlag){
            players[msg.sender].isNode = true;
        }
    }

    constructor() public {
        initJackpot();
        uint[] memory t_scale = new uint[](10);
        t_scale[0] = 10;
        t_scale[1] = 8;
        t_scale[2] = 7;
        t_scale[3] = 2;
        t_scale[4] = 1;
        t_scale[5] = 1;
        t_scale[6] = 1;
        t_scale[7] = 2;
        t_scale[8] = 4;
        t_scale[9] = 6;
        rewardScale = t_scale;
        players[msg.sender] = playerObj({
            state:true,
            joinState:false,
            input:0,
            nomalMax:0,
            output:0,
            totalProfit:0,
            nomalProfit:0,
            teamProfit:0,
            gameBalance:0,
            invit:new address[](10),
            recommand:new uint[](11),
            reserve:0,
            teamJoin:0,
            isNode:false
        });
    }
    
    function preShip(address _invit) external {
        require(players[_invit].state,'recommender not exist');
        require(!players[msg.sender].state,'Player already exists');
        address[] memory myinvit = new address[](10);
        myinvit[0] = _invit;
        players[_invit].recommand[1]+=1;
        for(uint i = 0;i<9;i++){
            if(players[_invit].invit[i]!=address(0x0)){
                myinvit[i+2] = players[_invit].invit[i];
                players[players[_invit].invit[i]].recommand[i+2]+=1;
            }else{
                break;
            }
        }
        
        
        players[msg.sender] = playerObj({
            state:true,
            joinState:false,
            input:0,
            nomalMax:0,
            output:0,
            totalProfit:0,
            nomalProfit:0,
            teamProfit:0,
            gameBalance:0,
            invit:myinvit,
            recommand:new uint[](11),
            reserve:0,
            teamJoin:0,
            isNode:false
        });
        emit InvitEvent(_invit,msg.sender,now);
    }

    function setNextPeriods() external {
        require(msg.sender == firePowerContract,'No authority');
        periods ++;
    }
    
    function getSuperNode() external view returns(address[] memory){
        return token.superNode();
    }

    function getSuperNodeState() external view returns(bool){
        address[] memory nodeList = token.superNode();
        bool nodeFlag = false;
        for(uint ii = 0; ii<nodeList.length;ii++){
            if(nodeList[ii] == msg.sender){
                nodeFlag = true;
                break;
            }
        }
        return nodeFlag;
    }
    
    function gameInfo() external view returns(bool,uint,uint,uint,uint){
        return (gameState,periodsLimit(),minJoinAmount,jackpot[jackpotIndex].pool,jackpot[jackpotIndex].water);
    }
    
    function gameIndexInfo() external view returns(bool,uint,uint){
        return (gameState,periods,totalJoin);
    }
    
    function invitInfo(address _address) view external returns(address){
        return players[_address].invit[0];
    }
    
    function recommandInfo(address _address) view external returns(uint[] memory){
        return players[_address].recommand;
    }

}