// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//ERC20 TOKEN STANDARD INTERFACE
interface ERC20Interface {

    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint balance) ;

    function allowance(address owner, address spender) external view returns (uint remaining);

    function transfer(address recipient, uint amount) external returns (bool success);

    function approve(address spender, uint amount) external returns (bool success);

    function transferFrom(address owner, address spender, uint amount) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint value);

    event Approval(address indexed owner, address indexed  spender, uint value);
}


//真的token合约
contract ERC20_MANUALLY is ERC20Interface {

    string public symbol;
    string public name;
    uint8 public decimals;
    uint public _totalSupply;

    mapping (address => uint) balances;   //钱包中余额
    mapping (address => mapping (address => uint)) allowed; //钱包中的多个地址
    //it lists the allowances for a specific wallet, it can have multiple other addresses
    //that are allowed to spend the token and then it says how much those addresses can spend this is to make sure that
    //the smart contract doesn't spend the tokens that the current user doesn't have

    //构造函数
    constructor(){
        symbol = "LIN";        //symbol of token
        name = "LEARN Coin";   //name of token
        decimals = 18;         //18位
        _totalSupply = 1_000_001_000_000_000_000_000_000;  //100W +1 个代币
        balances[0xBC9c5bD5eC8f4FE7Dd0988EC236931122dc69f79] = _totalSupply ; //给自己钱包地址赋值总供应量
        emit Transfer(address(0), 0xBC9c5bD5eC8f4FE7Dd0988EC236931122dc69f79, _totalSupply);
    }

    function totalSupply() public view returns (uint){
        return _totalSupply - balances[address(0)];
    }


    function balanceOf(address account) public view returns (uint balance){
        return balances[account];
    }

    function transfer(address recipient, uint amount) public returns (bool success){
        balances[msg.sender] = balances[msg.sender]- amount;
        balances[recipient] = balances[recipient] + amount;
        emit Transfer(msg.sender, recipient, amount);
        return  true;
    }

    function approve(address spender, uint amount) public returns (bool success){
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint amount) public returns  (bool success){
        balances[sender] = balances[sender]- amount;
        allowed[sender][msg.sender] = allowed[sender][msg.sender] - amount;
        balances[recipient] = balances[recipient] +amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint remaining){
        return allowed[owner][spender];
    }
}
