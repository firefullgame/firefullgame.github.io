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
        uint totalProfit;
        uint nomalProfit;
        uint teamProfit;
        uint gameBalance;
        address[] invit;
        uint recommand;
        uint index;
        uint reserve;
        //uint profitRound;
        uint teamJoin;
        bool isNode;
    }
    

    /*struct roundObj{
        uint totalInput;
        uint currentJoin;
        uint currentTime;
    }*/
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
    //游戏参数
    uint public periods = 1;
    uint public totalJoin = 0;
    uint public currentJoin = 0;
    uint public currentRound = 1;
    uint public sedimentaryAsset = 0;
    uint public playerCounter = 0;
    uint public minJoinAmount = 2000 trx;
    uint public burnTicket = 0;
    uint public nextBurn = 6000000 trx;
    mapping(uint => uint) public gameProgress;
    mapping(address => playerObj) public players;
    //mapping(uint => roundObj) public rounds;
    mapping(uint => address) public joinPlayerList;
    address[] public currentPlayerList = new address[](0);
    uint public currentPlayerHead = 0;
    uint public currentPlayerIndex = 0;
    bool public gameState = false;

    //事件
    event WithdrawEvent(address indexed _player,uint _amount,uint time);
    event InvitEvent(address indexed _from,address _player,uint _joinAmount,uint time);
    event JoinEvent(address indexed _player,uint _joinAmount,uint time);
    event ProfitRewardEvent(address indexed _player,uint _rewardAmount,uint time);
    event TeamRewardEvent(address indexed _player,address _invit,uint _level, uint _rewardAmount,uint time);
    event PrizeEvent(address indexed _player,uint _jackpot,uint _prize,uint _amount,uint time);
    event SuperNodeEvent(address indexed _player,uint _total,uint _amount,uint time);
    event leaveGameEvent(address indexed _player,uint _output,uint time);

    //奖金参数
    uint[] public rewardScale = new uint[](10);

    //奖池参数
    uint public jackpotIndex = 1;
    mapping(uint=>jackpotObj) public jackpot;

    //技术保留参数
    uint public retainScale = 3;
    uint public retainFlag = 0;
    
    //超级节点参数
    mapping(address => superNodeObj) public superNodeList;

    function periodsLimit() public view returns(uint){
        if(periods < 3){
            return 150000 trx;
        }else if(periods < 11){
            return 450000 trx;
        }else{
            return 1500000 trx;
        }
    }


    //参与倍数
    function joinScale(uint _amount) internal pure returns (uint){
        if(_amount >= 2000 trx && _amount <= 150000 trx){
            return 26;
        }else if(_amount > 150000 trx && _amount<= 450000 trx){
            return 32;
        }else if(_amount > 450000 trx && _amount<= 1500000 trx){
            return 40;
        }else{
            return 0;
        }
    }

    //防止合约注入
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
    //参与游戏
    function join(address _invit) payable external{
        require(msg.value <= periodsLimit(),'Period Maxmum limit exceeded');
        require(msg.value >= minJoinAmount,'Period Minimum limit exceeded');
        require(gameState,'Game Not Start');
        //1.判断金额限制
        uint scale = joinScale(msg.value);
        uint profit = msg.value.mul(scale).div(10);
        //2.判断门票
        uint ticket = msg.value.mul(100).div(gameProgress[periods]);
        uint tokenBalance = token.balanceOf(msg.sender);
        require(tokenBalance >= ticket,'ticket not enough');
        
        require(_invit != msg.sender,'The recommended address cannot be your own address');
        playerCounter = playerCounter + 1;
        joinPlayerList[playerCounter] = msg.sender;
        
        
        //3.加入静态池
        //profitRewardLog();
        gameReward();
        currentJoin = currentJoin.add(msg.value);
        totalJoin = totalJoin.add(msg.value);
        
        //4.创建，更新个人信息
        if(players[msg.sender].state == false){
            //---------处理推荐关系
            address[] memory myinvit = new address[](10);
            if(_invit != address(this) && players[_invit].state != false){
                //有推荐人
                myinvit[0] = _invit;
                for(uint i = 0;i<9;i++){
                    if(players[_invit].invit[i]!=address(0x0)){
                        myinvit[i+1] = players[_invit].invit[i];
                    }else{
                        break;
                    }
                }
                players[_invit].recommand+=1;
                if(players[_invit].isNode == true && superNodeList[_invit].isActive == false && players[_invit].teamJoin >= 200 trx && players[_invit].recommand >= 5){
                    superNodeList[_invit].isActive = true;
                }
                emit InvitEvent(_invit,msg.sender,msg.value,now);
            }

            address[] memory nodeList = token.superNode();
            bool nodeFlag = false;
            for(uint ii = 0; ii<nodeList.length;ii++){
                if(nodeList[ii] == msg.sender){
                    nodeFlag = true;
                    break;
                }
            }
            currentPlayerList.push(msg.sender);
            currentPlayerIndex++;

            //新用户
            players[msg.sender] = playerObj({
                state:true,
                joinState:true,
                input:msg.value, 
                output:profit,
                totalProfit:0,
                nomalProfit:0,
                teamProfit:0,
                gameBalance:0,
                invit:myinvit,
                recommand:0,
                reserve:0,
                index:currentPlayerIndex,
                //profitRound:currentRound,
                teamJoin:0,
                isNode:nodeFlag
            });
            superNodeList[msg.sender] = superNodeObj({
                isActive:false,
                profit:0,
                profitFlag:0
            });
            
        }else{
            //老用户
            playerObj memory player = players[msg.sender];
            if(player.joinState == true){
                //settleProfit(msg.sender);
                if(player.input.add(msg.value) > periodsLimit()){
                    player.reserve = player.reserve.add(msg.value);
                }else{
                    player.input = player.input.add(msg.value);
                    uint _scale = joinScale(player.input);
                    player.output = player.input.mul(_scale).div(10);
                }
            }else{
                currentPlayerList.push(msg.sender);
                currentPlayerIndex++;
                player.input = msg.value;
                player.output = profit;
                player.totalProfit = 0;
                player.nomalProfit = 0;
                player.teamProfit = 0;
                player.joinState = true;
                //player.profitRound = currentRound;
            }
            players[msg.sender] = player;
        }
        

        
        //5.动态
        teamReward();
        //6.奖池
        joinJackpot();
        //7.销毁门票
        burnTicket = burnTicket.add(ticket);
        token.burn(msg.sender,ticket);
        //8.判断当前数量，进入下一期
        setNextPeriods();
        emit JoinEvent(msg.sender,msg.value,now);
    }

    //加入静态池
    /*function profitRewardLog() internal{
        if(rounds[currentRound].currentTime + 3 < now){
            rounds[currentRound].currentJoin = currentJoin;
            currentRound += 1;
            rounds[currentRound] = roundObj({
                totalInput : 0,
                currentJoin : 0,
                currentTime : now
            });
        }

        rounds[currentRound].totalInput = rounds[currentRound].totalInput.add(msg.value.mul(35).div(100));
        currentJoin = currentJoin.add(msg.value);
        totalJoin = totalJoin.add(msg.value);
    }*/
    //设置门票合约
    function setFirePowerContract(address _firePowerContract) external onlyOwner returns(bool){
        firePowerContract = _firePowerContract;
        token = FirePowerToken(firePowerContract);
        return true;
    }
    //设置最小参与金额
    function setMinJoinAmount(uint _amount) external onlyOwner returns (bool){
        minJoinAmount = _amount;
        return true;
    }
    //收益提现
    function withdraw() external isHuman{
        //settleProfit(msg.sender);
        uint balance = players[msg.sender].gameBalance;
        players[msg.sender].gameBalance = 0;
        msg.sender.transfer(balance);
        emit WithdrawEvent(msg.sender,balance,now);
    }
    //技术保留提取
    function retainWithdraw() external onlyOwner{
        require(totalJoin != retainFlag,'retain amount not enoug');
        uint amount = totalJoin.sub(retainFlag).mul(retainScale).div(100);
        msg.sender.call.value(amount)("");
        retainFlag = totalJoin;
        emit WithdrawEvent(msg.sender,amount,now);
    }
    //沉淀资金提取
    function sedimentaryAssetWithdraw(uint _amount) external onlyOwner{
        require(sedimentaryAsset >= _amount,'sedimentary asset not enoug');
        msg.sender.call.value(_amount)("");
        sedimentaryAsset = sedimentaryAsset.sub(_amount);
        emit WithdrawEvent(msg.sender,sedimentaryAsset,now);
    }

    //辅助结算
    // function manualSettleProfit(address[] calldata settlePlayers) external onlyOwner{
    //     for(uint i = 0;i<settlePlayers.length;i++){
    //         settleProfit(settlePlayers[i]);
    //     }
    // }
    //结算静态收益 //internal
    /*function settleProfit(address _player) internal{
        playerObj memory player = players[_player];
        if(player.profitRound != currentRound && player.joinState == true){
            uint _profit = 0;
            uint profitLimit = player.output.sub(player.totalProfit);
            for(uint i = player.profitRound;i<currentRound;i++){
                _profit = _profit.add(rounds[i].totalInput.mul(player.input).div(rounds[i].currentJoin));
                if(_profit >= profitLimit){
                    _profit = profitLimit;
                    break;
                }
            }
            player.totalProfit = player.totalProfit.add(_profit);
            player.nomalProfit = player.nomalProfit.add(_profit);
            player.gameBalance = player.gameBalance.add(_profit);
            player.profitRound = currentRound;
            players[_player] = player;
            if(player.totalProfit == player.output){
                leaveGame(_player);
            }
            
            emit ProfitRewardEvent(_player,_profit,now);
        }
    }*/
    function gameReward() internal {
        uint reward = msg.value.mul(35).div(100);
        for(uint i = currentPlayerHead;i<currentPlayerIndex;i++){
            playerObj memory player = players[currentPlayerList[i]];
            
            uint _reward = reward.mul(player.input).div(currentJoin);
            if(player.totalProfit.add(_reward) >= player.output){
                _reward = player.output.sub(player.totalProfit);
            }
            player.totalProfit = player.totalProfit.add(_reward);
            player.nomalProfit = player.nomalProfit.add(_reward);
            player.gameBalance = player.gameBalance.add(_reward);
            players[currentPlayerList[i]] = player;
            emit ProfitRewardEvent(currentPlayerList[i],_reward,now);
            if(player.totalProfit == player.output){
                leaveGame(currentPlayerList[i]);
            }
        }
    }
    //动态
    function teamReward() internal{
        address[] memory myInvit = players[msg.sender].invit;
        for(uint i = 0;i < myInvit.length;i++){
            uint reward = msg.value.mul(rewardScale[i]).div(100);
            if(myInvit[i] == address(0x0)){
                sedimentaryAsset = sedimentaryAsset.add(reward);
                continue;
            }
            //settleProfit(myInvit[i]);
            players[myInvit[i]].teamJoin = players[myInvit[i]].teamJoin.add(msg.value);
            if(players[myInvit[i]].isNode == true && superNodeList[myInvit[i]].isActive == false && players[myInvit[i]].teamJoin >= 200 trx && players[myInvit[i]].recommand >= 5){
                superNodeList[myInvit[i]].isActive = true;
            }
            uint needRecommand = (i+1)/2 + (i+1)%2;
            if(players[myInvit[i]].recommand >= needRecommand && players[myInvit[i]].joinState == true){
                players[myInvit[i]].totalProfit = players[myInvit[i]].totalProfit.add(reward);
                if(players[myInvit[i]].totalProfit > players[myInvit[i]].output){
                    uint split = players[myInvit[i]].totalProfit.sub(players[myInvit[i]].output);
                    reward = reward.sub(split);
                     if(split > 0){
                        sedimentaryAsset = sedimentaryAsset.add(split);
                    }
                    players[myInvit[i]].totalProfit = players[myInvit[i]].output;
                    leaveGame(myInvit[i]);
                }else if(players[myInvit[i]].totalProfit == players[myInvit[i]].output){
                    leaveGame(myInvit[i]);
                }

                
                players[myInvit[i]].teamProfit = players[myInvit[i]].teamProfit.add(reward);
                players[myInvit[i]].gameBalance = players[myInvit[i]].gameBalance.add(reward);
                
                emit TeamRewardEvent(myInvit[i],msg.sender,i+1, reward,now);
            }else{
                sedimentaryAsset = sedimentaryAsset.add(reward);
            }
        }
    }
    //出局
    function leaveGame(address _player) internal{
        playerObj memory player = players[_player];
        if(player.totalProfit >= player.output && player.joinState == true){
            emit leaveGameEvent(_player,player.totalProfit,now);
            if(player.reserve > 0){
                //自动复投
                currentJoin = currentJoin.sub(player.input);
                uint limit = periodsLimit();
                uint reInput = 0;
                if(player.reserve > limit){
                    player.reserve = player.reserve.sub(limit);
                    reInput = limit;
                }else{
                    reInput = player.reserve;
                    player.reserve = 0;
                }
                currentJoin = currentJoin.add(reInput);
                
                uint scale = joinScale(reInput);
                player.input = reInput;
                player.output = player.input.mul(scale).div(10);
                player.totalProfit = 0;
                player.nomalProfit = 0;
                player.teamProfit = 0;
                //player.profitRound = currentRound;
                
            }else{
                player.joinState = false;
                currentPlayerList[player.index] = currentPlayerList[currentPlayerHead];
                players[currentPlayerList[currentPlayerHead]].index = player.index;
                currentPlayerHead++;
                player.index = 0;
                if(player.invit[0] != address(0x0)){
                    players[player.invit[0]].recommand -= 1;
                    if(players[player.invit[0]].isNode == true && superNodeList[player.invit[0]].isActive == true &&  players[player.invit[0]].recommand < 5){
                        superNodeList[player.invit[0]].isActive = false;
                    }
                }
                currentJoin = currentJoin.sub(player.input);
            }
            players[_player] = player;
            
        }
    }
    //奖池
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
    //获取下期期号
    function nextJackpot() internal view returns(uint){
        if(jackpotIndex < 5){
            return jackpotIndex + 1;
        }else{
            return 1;
        }
    }
    //奖池开奖
    function drawJackpot(uint surplus) internal{
        require(jackpot[jackpotIndex].water == jackpot[jackpotIndex].pool,'jackpot error');
        uint reward = jackpot[jackpotIndex].water.mul(jackpot[jackpotIndex].scale).div(100);
        uint index = 1;
        uint _reward = 0;
        uint _prize = 0;
        for(uint i = playerCounter;i > playerCounter.sub(31);i--){
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
            if(players[joinPlayerList[i]].totalProfit.add(_reward) >= players[joinPlayerList[i]].output){
                players[joinPlayerList[i]].totalProfit = players[joinPlayerList[i]].output;
                leaveGame(joinPlayerList[i]);
            }
            players[joinPlayerList[i]].gameBalance = players[joinPlayerList[i]].gameBalance.add(_reward);
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
    //超级节点提现
    function superNodeWithdraw() external isHuman{ 
        require(players[msg.sender].isNode,"You're not a super node");
        require(superNodeList[msg.sender].isActive,"You haven't activated the super node yet");
        uint flag = totalJoin.sub(superNodeList[msg.sender].profitFlag);
        require(flag > 1,"You don't have any new profit yet");
        superNodeList[msg.sender].profitFlag = totalJoin;
        uint profit = flag.mul(5).div(12800);
        superNodeList[msg.sender].profit = superNodeList[msg.sender].profit.add(profit);
        msg.sender.transfer(profit);
        emit SuperNodeEvent(msg.sender,flag,profit,now);
    }
    
    function superNodeProfit() external view returns(uint){
        uint flag = totalJoin.sub(superNodeList[msg.sender].profitFlag);
        return flag.mul(5).div(12800);
    }
    //切换下一期
    function setNextPeriods() internal{
        if(burnTicket >= nextBurn){
            periods = periods + 1;
            gameProgress[periods] = gameProgress[periods - 1].mul(140).div(100);
            uint totalSupply = token.totalSupply();
            uint newBurn = totalSupply.mul(20).div(100);
            nextBurn = nextBurn.add(newBurn);
        }
    }

    //初始化奖池
    function initJackpot() internal{
        jackpot[1] = jackpotObj({pool:1500000 trx,water:0,scale:60});
        jackpot[2] = jackpotObj({pool:3000000 trx,water:0,scale:60});
        jackpot[3] = jackpotObj({pool:4500000 trx,water:0,scale:60});
        jackpot[4] = jackpotObj({pool:6000000 trx,water:0,scale:60});
        jackpot[5] = jackpotObj({pool:7500000 trx,water:0,scale:90});
    }

    //获取当前门票兑换数量
    function getProgressScale() external view returns(uint){
		uint total = 1e9;
		return total.div(gameProgress[periods]);
    }

    function myInvitList() external view returns(address[] memory,address,bool){
        return (players[msg.sender].invit,address(0x0),players[msg.sender].invit[0] == address(0x0));
    }
    
    function startGame() external {
            require(msg.sender == firePowerContract,'');
            gameState = true;
    }
    
    //构造方法
    constructor() public {
        // rounds[currentRound] = roundObj({
        //     totalInput : 0,
        //     currentJoin : 0,
        //     currentTime : 0
        // });
        gameProgress[1] = 12941;
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
    }
}