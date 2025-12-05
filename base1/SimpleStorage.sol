// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

 contract SimpleStorage{

    uint256 favoriteNumber;

    mapping (string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public virtual  {
        favoriteNumber = _favoriteNumber;
        favoriteNumber = favoriteNumber+1;
    }
      // view, pure
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public peoples;

    function addPeople(uint256 _favoriteNumber,  string memory _name ) public {
        peoples.push(People(_favoriteNumber,_name));
        nameToFavoriteNumber[_name]=_favoriteNumber;
    }
}