// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReverseString {


    // 按字节反转字符串 如果是中文的话需特殊处理
    function reverse(string memory s) public pure returns(string memory) {
        bytes memory b = bytes(s);
        uint256 len = b.length;

        bytes memory receives = new bytes(len);

        for(uint i=0;i<len;i++){
            receives[i] = b[len-1-i];
        }
        return string(receives);
    }
}