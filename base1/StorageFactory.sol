// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage public simpleStorage;
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex,uint256 _simpleStorageNumer) public {
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumer);
    }

     function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }

}