//以下是在之前代码基础上，满足你新需求的Solidity合约代码：

// SPDX - License - Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/structs/EnumerableMap.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

contract BeggingV2 {
    
    using EnumerableMap for EnumerableMap.AddressToUintMap;
    using EnumerableSet for EnumerableSet.AddressSet;

    // 用于记录每个捐赠者的捐赠金额
    EnumerableMap.AddressToUintMap private donations;
    // 用于记录捐赠者地址集合
    EnumerableSet.AddressSet private donors;
    // 合约所有者
    address public owner;
    // 捐赠事件
    event Donation(address indexed donor, uint256 amount, uint256 timestamp);
    // 捐赠截止时间（2025年6月30日 23:59:59 假设以秒为单位的Unix时间戳）
    uint256 public donationEndTime = 1793404799;
    
    constructor() {
        owner = msg.sender;
    }

    // 允许用户向合约发送以太币，并记录捐赠信息
    function donate() public payable {
    require(block.timestamp <= donationEndTime, "Donation period has ended");
    uint256 oldAmount = donations.get(msg.sender);
    uint256 newAmount = oldAmount + msg.value;
    donations.put(msg.sender, newAmount);
    if (!donors.contains(msg.sender)) {
    donors.add(msg.sender);
    }
    emit Donation(msg.sender, msg.value, block.timestamp);
    }

    // 允许合约所有者提取所有资金
    function withdraw() public {
    require(msg.sender == owner, "Only contract owner can withdraw");
    payable(owner).transfer(address(this).balance);
    }

    // 允许查询某个地址的捐赠金额
    function getDonation(address donor) public view returns (uint256) {
    return donations.get(donor);
    }

    // 获取捐赠金额最多的前三个地址
    function getTopThreeDonors() public view returns (address[3] memory) {
    address[3] memory topDonors;
    uint256[] memory amounts = new uint256[](donors.length());
    address[] memory allDonors = donors.values();
    
    for (uint256 i = 0; i < donors.length(); i++) {
    amounts[i] = donations.get(allDonors[i]);
    }

    for (uint256 i = 0; i < 3; i++) {
    uint256 maxIndex = 0;
    uint256 maxAmount = 0;
    for (uint256 j = 0; j < amounts.length; j++) {
    if (amounts[j] > maxAmount) {
    maxIndex = j;
    maxAmount = amounts[j];
    }
    }
    topDonors[i] = allDonors[maxIndex];
    amounts[maxIndex] = 0;
    }

    return topDonors;
    }
    }


//代码解释：
//
//1.引入库：
//- @openzeppelin/contracts/utils/structs/EnumerableMap.sol 和 @openzeppelin/contracts/utils/structs/EnumerableSet.sol 是OpenZeppelin提供的实用库，用于实现可枚举的映射和集合。
//- using EnumerableMap for EnumerableMap.AddressToUintMap; 和 using EnumerableSet for EnumerableSet.AddressSet; 让我们可以使用这些库提供的方法来操作 donations 映射和 donors 集合。
//2.新的状态变量：
//- donors：一个可枚举的地址集合，用于记录所有捐赠者的地址。
//- event Donation(address indexed donor, uint256 amount, uint256 timestamp);：定义了一个捐赠事件，当有新的捐赠时会触发，记录捐赠者地址、捐赠金额和捐赠时间。
//- donationEndTime：定义了捐赠的截止时间，这里设置为2025年6月30日23:59:59对应的Unix时间戳（假设）。
//3.donate 函数：
//- require(block.timestamp <= donationEndTime, "Donation period has ended");：检查当前区块链的时间戳是否在捐赠截止时间之前，如果超过截止时间则捐赠无效。
//- 记录捐赠金额的更新，同时将捐赠者地址添加到 donors 集合中（如果还没有添加过），并触发 Donation 事件。
//4.getTopThreeDonors 函数：
//- 首先创建数组来存储所有捐赠者的地址和对应的捐赠金额。
//- 通过循环遍历找到捐赠金额最大的前三个地址，并将它们存储在 topDonors 数组中返回。
//
//请注意：
//
//- 上述代码中的截止时间 donationEndTime 是假设值，你可以根据实际需求进行调整。
//- 这里使用了OpenZeppelin库，在部署合约时需要确保已经正确安装和配置了相关库。