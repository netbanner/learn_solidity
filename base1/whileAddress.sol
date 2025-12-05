// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract whileAddressContract {

    mapping (address=>bool) private whiteList;
    address [] private whiteAddressList;
    //批量添加地址白名单
    function batchAddWhitelist(address [] memory addresses) public {
        uint256 newAddressCount =0;

        for(uint i=0;i<addresses.length;i++){
            if(!whiteList[addresses[i]]&&addresses[i]!=address(0)){
                newAddressCount++;
            }
        }
        if(newAddressCount>0){
            uint256 len = whiteAddressList.length;
            address [] memory newAddresses = new address[](newAddressCount);
            uint256 index=0;

            for(uint i=0;i<addresses.length;i++){
                address _address = addresses[i];
                if (!whiteList[_address] && _address != address(0)) {
                    whiteList[_address] = true;
                    newAddresses[index] = _address;
                    index ++;
                
                }
            }
            uint256 newLength = len+newAddressCount;
            assembly {
                sstore(whiteList.slot, newLength)
            }
            // 添加新地址到主数组
            for (uint256 i = 0; i < newAddressCount; i++) {
                whiteAddressList[len + i] = newAddresses[i];
            }
        }
    }

    function hasDuplicate(address[] memory addresses) public pure returns (bool ){
        
        require(addresses.length <= 256, "array too big");
        if (addresses.length <= 1) return false;
         // 对于小数组，使用嵌套循环
        if (addresses.length <= 10) {
            for (uint256 i = 0; i < addresses.length - 1; i++) {
                for (uint256 j = i + 1; j < addresses.length; j++) {
                    if (addresses[i] == addresses[j]) {
                        return true;
                    }
                }
            }
            return false;
        }
        
        // 对于大数组，使用哈希表（通过mapping模拟）
        // 注意：这仍然需要O(n^2) gas，但比嵌套循环稍好
        return _checkLargeArrayDuplicates(addresses);
    }

    function _checkLargeArrayDuplicates(address[] memory array) private pure returns(bool){
         for (uint256 i = 0; i < array.length - 1; i++) {
            for (uint256 j = i + 1; j < array.length; j++) {
                if (array[i] == array[j]) {
                    return true;
                }
            }
        }
        return false;
    }

        /**
     * @dev 计算数组中所有偶数地址的和（将地址转换为uint256处理）
     * @param array 要计算的地址数组
     * @return evenSum 偶数地址的和
     */
    function sumEvenAddresses(address[] memory array) public pure returns (uint256 evenSum) {
        evenSum = 0;
        
        for (uint256 i = 0; i < array.length; i++) {
            uint256 addrValue = uint256(uint160(array[i]));
            
            // 检查是否为偶数（最低位为0）
            if (addrValue & 1 == 0) {
                evenSum += addrValue;
            }
        }
        
        return evenSum;
    }

    /**
     * @dev 计算数组中所有偶数（数值数组）的和
     * @param numbers 数值数组
     * @return evenSum 偶数的和
     */
     function sumEvenNumbers(uint256[] memory numbers) public pure returns (uint256 evenSum){
        evenSum =0;

        for(uint i=0;i<numbers.length;i++){
            if(numbers[i]&1==0){
                evenSum +=numbers[i];
            }
        }

        return evenSum;
     }

     /**
     * @dev 优化的白名单检查（使用mapping，O(1)复杂度）
     * @param account 要检查的地址
     * @return isWhitelisted 是否在白名单中
     */
    function isWhitelisted(address account) public view returns (bool) {
        return whiteList[account];
    }
    
    /**
     * @dev 获取白名单数组（优化版本，避免复制大数组）
     * @return 白名单地址数组
     */
    function getWhitelistArray() public view returns (address[] memory) {
        return whiteAddressList;
    }
    
    /**
     * @dev 获取白名单长度
     * @return 白名单长度
     */
    function getWhitelistLength() public view returns (uint256) {
        return whiteAddressList.length;
    }

    /**
     * @dev 优化的数组反转函数（减少内存分配）
     * @param input 输入数组
     * @return reversed 反转后的数组
     */
    function revertArray(uint256[] memory input) public pure returns(uint256[] memory reversed){
        if (input.length ==0) {
            return input;
        }
        reversed = new uint256[](input.length);

        uint256 left=0;
        uint256 right = input.length-1;
        while (left<=right){
            reversed[left] = input[right];
            reversed[right] = input[left];
            left++;
            right++;
        }
        return reversed;
    }

    /**
     * @dev 批量检查地址是否在白名单中
     * @param accounts 要检查的地址数组
     * @return results 检查结果数组
     */
    function batchCheckWhitelist(address[] memory accounts)  public view returns (bool[] memory results) 
    {
        results = new bool[](accounts.length);
        
        for (uint256 i = 0; i < accounts.length; i++) {
            results[i] = whiteList[accounts[i]];
        }
        
        return results;
    }
}