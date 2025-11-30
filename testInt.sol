// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract testInt{

    int8 a = -1;
    int16 b = 16;
    uint32 c = 32;
    uint8 d = 8;

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
}