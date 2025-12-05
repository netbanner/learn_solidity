// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract DynamicAddressArray {

    address []private addressArray;

    // 添加地址到数组
    function addAddress(address _address) public {
        require(_address != address(0), "Invalid address");
        addressArray.push(_address);

    }

    //批量添加
    function addAddresses(address[] memory _addresses ) public   {

        for(uint i=0;i<_addresses.length;i++){
            require(_addresses[i] != address(0), "Invalid address in array");
            addressArray.push(_addresses[i]);
        }
    }

    //计算地址数组中所有地址的余额之和
    function getAddressOfBalanceSum(address[] memory _addresses) public view returns (uint256 totalBalance){
        totalBalance = 0;
        for (uint i=0;i<_addresses.length;i++){
            totalBalance +=_addresses[i].balance;
        }
        return totalBalance;
    }
    
    //计算合约内部地址数组中所有地址的余额之和

    function getInternalBalanceSum() public view  returns (uint256 totalBalance){
        return getAddressOfBalanceSum(addressArray);
    }

    //通过索引删除数组中的特定元素
    function removeByIndex(uint _index) public  {
        require(_index < addressArray.length, "Index out of bounds");
        //address removeAddress = addressArray[_index];
              // 将最后一个元素移动到要删除的位置
        addressArray[_index] = addressArray[addressArray.length - 1];
        
        // 删除最后一个元素
        addressArray.pop();
    }

    //通过地址值删除数组中的特定元素
    function removeByAddress(address _address) public   {
        require(_address!=address(0),"");
        bool found = false;
        uint removeIndex = 0;
        for (uint i=0;i<addressArray.length;i++){
            if(addressArray[i]==_address){
                found = true;
                removeIndex=i;
                break;
            }
        }
        require(found, "Address not found in array");
        removeByIndex(removeIndex);
    }

       
    /**
     * @dev 清空整个数组
     */
    function clearArray() public {
       
        
        // 通过循环删除所有元素
        for (uint256 i = addressArray.length; i > 0; i--) {
            addressArray.pop();
        }
        
 
    }
    
    /**
     * @dev 获取数组的当前长度
     * @return 数组长度
     */
    function getArrayLength() public view returns (uint256) {
        return addressArray.length;
    }
    
    /**
     * @dev 获取数组中的所有地址
     * @return 地址数组
     */
    function getAllAddresses() public view returns (address[] memory) {
        return addressArray;
    }
    
    /**
     * @dev 获取指定索引的地址
     * @param _index 索引
     * @return 地址
     */
    function getAddressAt(uint256 _index) public view returns (address) {
        require(_index < addressArray.length, "Index out of bounds");
        return addressArray[_index];
    }
    
    /**
     * @dev 检查地址是否存在于数组中
     * @param _address 要检查的地址
     * @return 是否存在
     */
    function containsAddress(address _address) public view returns (bool) {
        for (uint256 i = 0; i < addressArray.length; i++) {
            if (addressArray[i] == _address) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * @dev 获取数组中某个地址的索引
     * @param _address 要查找的地址
     * @return 索引，如果不存在则返回数组长度
     */
    function getAddressIndex(address _address) public view returns (uint256) {
        for (uint256 i = 0; i < addressArray.length; i++) {
            if (addressArray[i] == _address) {
                return i;
            }
        }
        return addressArray.length; // 返回长度表示未找到
    }
    
    /**
     * @dev 回退函数，接收以太币
     */
    receive() external payable {}
    
    /**
     * @dev 获取合约余额
     * @return 合约余额
     */
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
