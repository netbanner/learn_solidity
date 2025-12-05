// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IBank.sol";
contract BankUser{

    function depositToBank (address bankAddress) public  payable {
        IBank bank = IBank(bankAddress);
        bank.deposit{value:msg.value};
    }

    function withdrawFromBank(address bankAddress, uint256 amount) external {
        IBank bank = IBank(bankAddress);
        bank.withdraw(amount);
    }

    function getBankBalance(address bankAddress) external view returns (uint256) {
        IBank bank = IBank(bankAddress);
        return bank.getBalance();
    }

}