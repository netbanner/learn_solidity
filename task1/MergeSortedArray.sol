// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeSortedArray{


    function merge(uint256[] memory nums1,  uint256[] memory nums2 ) public pure returns(uint256[] memory nums){
        uint256 l1=nums1.length;
        uint256 l2 = nums2.length;
        nums = new uint256[](l1+l2);
        uint256 i;
        uint256 j;
        uint256 k;
         while (i < l1 && j < l1) {
            if (nums1[i] <= nums2[j]) {
                nums[k++] = nums1[i++];
            } else {
                nums[k++] = nums2[j++];
            }
        }
        while(i<l1){
            nums[k++] = nums1[i++];
        }
        while(j<l2){
            nums[k++] = nums2[j++];
        }
        return nums;
    }
}