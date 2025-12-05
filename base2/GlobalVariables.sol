// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract GlobalVariable {

    function getBlockDetails() public view returns (uint, uint) {
        return (block.number, block.timestamp);
    }

    function getTxOrigin() public view returns (address) { 
        return (tx.origin); 
    } 

    function getMessageDetails() public payable returns (address, uint) {
        return (msg.sender, msg.value);
    }

    function getContractDetails() public view returns (address, uint) {
        return (address(this), address(this).balance);
    }

    function getContractAddress() public view returns (address) {
        return address(this);
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getHash(string memory input) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(input));
    }
    //应用场景 ✅ 随机数生成（⚠️ 仅限低安全性用途）
    function getRandomNumber() public view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 100;
    }

    //安全认证
    address public owner;
    constructor() { owner = msg.sender; }
    function isOwner() public view returns (bool) {
        return msg.sender == owner;
    }
}