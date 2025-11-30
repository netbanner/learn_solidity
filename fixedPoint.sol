// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract FixedPoint {
    uint256 constant DECIMALS = 3; // 3 位小数
    uint256 constant BASE = 10 ** DECIMALS;

    function multiply(uint256 a, uint256 b) public pure returns (uint256) {
        return (a * b) / BASE;
    }

    function divide(uint256 a, uint256 b) public pure returns (uint256) {
        return (a * BASE) / b;
    }
}