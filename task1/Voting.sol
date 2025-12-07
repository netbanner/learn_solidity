// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {

    mapping ( string => uint256 ) public votesReceived;
    //投票人
    string[] private voteList;

 // 投票事件
    event VoteCast(string indexed candidate, address indexed voter);
      // 防止重复登记
    mapping(string => bool) private isRegistered;

    //投票
    function vote(string memory candidate) external  {
        if (!isRegistered[candidate]) {
            isRegistered[candidate] = true;
            voteList.push(candidate);
        }
        votesReceived[candidate] += 1;
        emit VoteCast(candidate, msg.sender);
    }
    //获取某人的投票数
    function getVotes(string memory candidate) external  view returns (uint256) {
        return votesReceived[candidate];
    }
    //重置所以投票
    function resetVotes() public {
        for (uint i = 0; i < voteList.length; i++) {
            votesReceived[voteList[i]] = 0;
        }

    }
    //获取总投票数
    function getTotalVotes() public view returns (uint256 totalVotes) {
        totalVotes = 0;
        for (uint i = 0; i < voteList.length; i++) {
            totalVotes += votesReceived[voteList[i]];
        }
    }

     /**
     * 获取当前已登记候选人的总数量
     * 方便前端遍历调试
     */
    function getCandidateCount() external view returns (uint256) {
        return voteList.length;
    }

    /**
     * 按索引获取候选人名称
     * 配合 getCandidateCount() 可遍历全部候选人
     */
    function getCandidateByIndex(uint256 index) external view returns (string memory) {
        require(index < voteList.length, "Index out of range");
        return voteList[index];
    }
        
}