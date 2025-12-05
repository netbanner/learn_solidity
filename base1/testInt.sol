// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract testInt{

    int8 a = -1;
    int16 b = 16;
    uint32 c = 32;
    uint8 d = 8;

    int public account = 1*2**255-1;
    
    uint public a2 = 1*2**256-1;
    bool public flag2 = false;
    bool public flag1 = true;
    address public  addr = 0xf79Dc8C6eaDD48cC6C1c8536e0b5e10c7d121970;
    
    bytes32 public  b2 = hex"1000";

    enum   Status {
        Active,
        InActive
    }

    function add(uint x,uint y) public pure returns (uint z){
        return x+y;
    }
    
    function divide(uint x,uint y) public pure returns (uint z) {
        return x/y;
    }
    function leftshift(int x, uint y) public pure returns (int z){
        z = x << y; 
    } 
    function rightshift(int x, uint y) public pure returns (int z){
        z = x >> y; 
    } 
    function testPlusPlus() public pure returns (uint ) { 
        uint x = 1; uint y = ++x; // c = ++a; 
        return y; 
    } 

    function add2(uint256 a, uint256 b) internal pure returns (uint256){ 
        uint256 c = a + b; 
    require(c >= a); // 做溢出判断，加法的结果肯定比任何一个元素大。
    return c; 
}
}