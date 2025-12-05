// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract fibonacci{

    function Fibonacci(uint n) public pure returns (uint256 result){
        require(n<=100,"n is so big ");
        if (n==0){
            return 0;
        }
        if(n==1){
            return 1;
        }
        uint256 a=0;
        uint256 b=1;
        for(uint i;i<=n;i++){
            uint256 temp = a + b;
            require(temp >= b, "Overflow protection"); // 防止溢出
            a = b;
            b = temp;
        }
        return b;
    }
}