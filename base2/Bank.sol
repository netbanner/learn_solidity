// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IBank.sol";

contract Bank is IBank{
 
 mapping(address => uint256) public balances;

 receive() external payable { }

 function deposit() external payable override {
        require(msg.value > 0, unicode"存款金额必须大于0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external override {
        require(balances[msg.sender] >= amount, unicode"余额不足");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance() external view override returns (uint256) {
        return balances[msg.sender];
    }
}