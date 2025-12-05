// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MapppingDemoContract {
        
    mapping(address =>uint256) public balances;

    function setBalance(uint256 amount) public {
        balances[msg.sender] = amount;
    }

    function getBalance(address user) public view returns(uint256){
        return balances[user];
    }

    mapping (address =>mapping (string=>uint256)) public userBalances;

    function setUserBalance(string memory currency,uint256 amount)public {
        userBalances[msg.sender][currency] = amount;
    }

    function getUserBalance(string memory currency,address  user) public view returns(uint256){
        return userBalances[user][currency];
    }

  struct User {
        string name;
        uint256 age;
        address wallet;
    }
    mapping(address => User) public users;

    function setUser(string memory name, uint256 age) public {
        users[msg.sender] = User(name, age, msg.sender);
    }
    function getUser(address userAddress) public view returns (string memory, uint256, address) {
        User memory user = users[userAddress];
        return (user.name, user.age, user.wallet);
    }

     User[] public userArrays;
    function addUser(string memory name, uint256 age,address wallet) public {
        userArrays.push(User(name, age,wallet));
    }

}