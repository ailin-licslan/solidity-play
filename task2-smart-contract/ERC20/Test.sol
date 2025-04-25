// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    //
    // constructor() ERC20("MyToken", "MYT") {

    // }

    address payable public owner;


    //定义存放账号地址====> 对应余额
    mapping(address account => uint256) public _balances;

    uint8 private immutable _decimals;

    //构造函数 继承一个ERC20
    constructor(string memory name, string memory symbol, uint8 decimals_) ERC20(name, symbol){
        _decimals = decimals_;
        owner = payable(msg.sender);
    }

    //mint 代币  生产代币  地址  & 数量
    function mint(address account, uint256 amount ) external {
        //_mint(msg.sender, amount);
        _mint(account, amount);
    }

    //burn代币  燃烧代币 地址 & 数量
    function burn(address from, uint256 amount) external {
        _burn(from, amount);
    }

    //修改精度  原始ERC20代码
    // function decimals() public view virtual returns (uint8) {
    //     return 18;
    // }
    //修改精度
    function decimals() public view  override returns (uint8) {
        return _decimals;
    }

    //0xBC9c5bD5eC8f4FE7Dd0988EC236931122dc69f79
    //0xBC9c5bD5eC8f4FE7Dd0988EC236931122dc69f79


}











//https://www.youtube.com/watch?v=88-hpZE4OU8
//ERC20代币规范  关于ERC20定义的一些interface的理解

//name : token name
//symbol : the symbol of token E.g "ETH"
//decimals: 精度  18 个 0  wei
//totalSupply token 总供应量
//balance of : the account balance of another account with address _owner 每个人的账户持有代币数量 这个账本记录所有人在以太坊上面持有代币的数量
//transfer:  想把自己的币transfer给别人  function transfer 2个参数 address _to(给谁) uint256 _value (给多少)  这个transfer的发起人一定是这个币的持有人
//transferFrom : 2个参数 address _from & address _ to
//_from:我先授权给其他人，可以调用我拥有的代币  其他人来调用这个transfer_from (场景Uni swap)
//使用transferFrom前 先要调用一下approve功能(允许某个合约来操作我的代币) approve uni swap合约来操作我的代币 且限制数量
//uni swap合约来调用这个transferFrom (填持币人地址),approve之后, allowance 可以让你查询到现在谁有权可以动用某些人的多少代币
//event : 我们做某些操作时记录需要触发的一些的东西 日志之类的 ERC20 2个 event transfer(转账触发的event) & approval(授权触发的event)