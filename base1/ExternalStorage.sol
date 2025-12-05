// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import "./SimpleStorage.sol";

contract ExteranlStorage is SimpleStorage{

 // 重载
function store(uint256 _favoriteNumber) public override{
        favoriteNumber = _favoriteNumber + 5;
    }
}