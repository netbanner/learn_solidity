// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch {



    function binary(uint256[] memory arr,uint256 target) external pure  returns(int256){
        uint256 length = arr.length;

        uint256 low = 0;
        uint256 high = length - 1;
      
        while(low<=high){
            uint256 mid = low+(high-low)/2;
            if(arr[mid]==target){
                return int256(mid);
            }
            if (arr[mid] < target) {
                low = mid + 1;
            } else {
                high = mid-1;
            }
        }
       return -1; 
    }
}