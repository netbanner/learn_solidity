// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract RomanToInt {
    function romanToInt(string memory s) external pure returns (uint256 num) {
        uint256 len = bytes(s).length;
        if (len == 0) return 0;

        bytes memory b = bytes(s);

        for (uint256 i = 0; i < len - 1; ++i) {
            uint256 cur = _val(b[i]);
            uint256 next = _val(b[i + 1]);
            cur < next ? num -= cur : num += cur;
        }
        num += _val(b[len - 1]);   // 最后一个必定加
    }

    // 纯函数内部 helper
    function _val(bytes1 c) private pure returns (uint256) {
        if (c == "I") return 1;
        if (c == "V") return 5;
        if (c == "X") return 10;
        if (c == "L") return 50;
        if (c == "C") return 100;
        if (c == "D") return 500;
        if (c == "M") return 1000;
        revert("Invalid roman char");
    }
}