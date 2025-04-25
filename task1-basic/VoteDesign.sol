// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;



contract VoteDesign{

    // 一个mapping来存储所有候选人的得票数  地址 + 得票数
    mapping(address => uint256) public votes;

    // 记录所有候选人
    address[] public candidates;

    // 一个vote函数，允许用户投票给某个候选人
    function voting(address candidate) public {

        // 如果没有被投过票 新候选人
        if (votes[candidate] == 0) {
            candidates.push(candidate);
        }

        //已经投过直接+1
        votes[candidate] += 1;
    }

    // 一个getVotes函数，返回某个候选人的得票数
    function getVoteByAddress(address candidate) public view returns (uint256) {
        return votes[candidate];
    }

    // 一个resetVotes函数，重置所有候选人的得票数
    function resetVotes() public {
        for(uint i = 0; i < candidates.length; i++) {
            votes[candidates[i]] = 0;
        }
    }
}
