// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntToRom {
    string[10] private  R1;
    string[10] private  R10;
    string[10] private  R100;
    string[4] private  R1000;

    constructor() {
        R1 = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"];
        R10 = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"];
        R100 = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"];
        R1000 = ["", "M", "MM", "MMM"];
    }

    function int2Rom(uint256 num) external view returns (string memory) {
        require(num > 0 && num < 4000, "out of range");
        return string(abi.encodePacked(
            R1000[num / 1000],
            R100[num / 100 % 10],
            R10[num / 10 % 10],
            R1[num % 10]
        ));
    }
}