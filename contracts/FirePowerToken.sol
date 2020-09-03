pragma solidity ^0.5.3;

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}
contract ERC20 is IERC20 {
    using SafeMath for uint;

    mapping (address => uint) internal _balances;

    mapping (address => mapping (address => uint)) private _allowances;

    uint internal _totalSupply;
    function totalSupply() public view returns (uint) {
        return _totalSupply;
    }
    function balanceOf(address account) public view returns (uint) {
        return _balances[account];
    }
    function transfer(address recipient, uint amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }
    function allowance(address owner, address spender) public view returns (uint) {
        return _allowances[owner][spender];
    }
    function approve(address spender, uint amount) public returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }
    function transferFrom(address sender, address recipient, uint amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }
    function increaseAllowance(address spender, uint addedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].add(addedValue));
        return true;
    }
    function decreaseAllowance(address spender, uint subtractedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }
    function _transfer(address sender, address recipient, uint amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }
    function _mint(address account, uint amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }
    function _burn(address account, uint amount) internal {
        require(account != address(0), "ERC20: burn from the zero address");

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }
    function _approve(address owner, address spender, uint amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
}
contract ERC20Detailed is IERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor (string memory name, string memory symbol, uint8 decimals) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
    }
    function name() public view returns (string memory) {
        return _name;
    }
    function symbol() public view returns (string memory) {
        return _symbol;
    }
    function decimals() public view returns (uint8) {
        return _decimals;
    }
}
library SafeMath {
    function add(uint a, uint b) internal pure returns (uint) {
        uint c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }
    function sub(uint a, uint b) internal pure returns (uint) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }
    function sub(uint a, uint b, string memory errorMessage) internal pure returns (uint) {
        require(b <= a, errorMessage);
        uint c = a - b;

        return c;
    }
    function mul(uint a, uint b) internal pure returns (uint) {
        if (a == 0) {
            return 0;
        }

        uint c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }
    function div(uint a, uint b) internal pure returns (uint) {
        return div(a, b, "SafeMath: division by zero");
    }
    function div(uint a, uint b, string memory errorMessage) internal pure returns (uint) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint c = a / b;

        return c;
    }
}
contract Ownable {
  address public owners;
  constructor() public {
    owners = msg.sender;
  }
  modifier onlyOwner() {
    require(owners == msg.sender,'Permission denied');
    _;
  }
}
interface FireFullGame {
    function startGame() external;
}
contract FirePowerToken is ERC20, ERC20Detailed, Ownable {
  using SafeMath for uint;
  address public owner;
  address public gameAddress;
  FireFullGame private game;
  address[] internal _superNode;
  uint public periods = 1;
  mapping(uint => mapping(uint => uint)) public periodsSupply;
  uint public startPeople = 0;
  event Buyer(address indexed buyer, uint amount, uint tokens,uint timeStamp);
  event InvitBuy(address indexed buyer, address indexed inviter,uint amount,uint invit,uint timeStamp);

  constructor () public ERC20Detailed("FirePowerToken", "FPT", 6) {
      owner = msg.sender;
      periodsSupply[1][0] = 265000 trx;
      periodsSupply[1][1] = 15000000 trx;
      periodsSupply[1][2] = 0 trx;
      periodsSupply[2][0] = 345000 trx;
      periodsSupply[2][1] = 9000000 trx;
      periodsSupply[2][2] = 0 trx;
      periodsSupply[3][0] = 410000 trx;
      periodsSupply[3][1] = 6000000 trx;
      periodsSupply[3][2] = 0 trx;
      _totalSupply = 30000000 trx;
  }
  
  function buy(address payable _invit) external payable{
      require(periods <= 3 ,"The Ended");
      require(msg.value == periodsSupply[periods][0],"Incorrect amount");
      uint supply = 300000 trx;
      _balances[msg.sender] = _balances[msg.sender].add(supply);
      periodsSupply[periods][2] = periodsSupply[periods][2].add(supply);
      if(_invit != address(0x0) && _invit != address(this) && _invit != msg.sender){
          invitReward(_invit);
      }
      _superNode.push(msg.sender);
      startPeople = startPeople + 1;
      if(periodsSupply[periods][2] >= periodsSupply[periods][1]){
          periods = periods + 1;
      }
      emit Buyer(msg.sender, msg.value, supply, now);
  }

  function invitReward(address payable _invit) internal{
      uint reward = msg.value.mul(15).div(100);
      _invit.transfer(reward);
      emit InvitBuy(msg.sender,_invit,msg.value,reward,now);
  }
  
  function currentNomalScale() external view returns (uint,uint) {
      return (periodsSupply[periods][0],300000 trx);
  }
  
  function startGame() internal{
      if(startPeople >= 4000 && periods > 3){
          game.startGame();
      }
  }
  
  function transfer(address recipient, uint amount) public returns (bool) {
    if(_balances[recipient] > 100){
            super.transfer(recipient, amount);
        }else {
            super.transfer(recipient, amount);
            if(_balances[recipient] >= 100){
                startPeople = startPeople + 1;
            }
        }
        
	if(_balances[msg.sender] < 100){
		startPeople = startPeople - 1;
	}
    startGame();
  } 
  
  function setOwner(address _owner) external onlyOwner{
      owner = _owner;
  }
  
  function setGame(address _gameAddress) external onlyOwner{
      gameAddress = _gameAddress;
      game = FireFullGame(gameAddress);
  }
  
  function burn(address account, uint amount) external returns(bool){
      require(msg.sender == gameAddress, "not game address");
      super._burn(account,amount);
      return true;
  }
  function superNode() external returns(address[] memory){
      return _superNode;
  }
  function withdraw() external onlyOwner {
        msg.sender.transfer(address(this).balance);
    }
 
}