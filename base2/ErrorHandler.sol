// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ErrorHandler {

    // require unicode需支付多些gas
    function transfer(address to, uint256 amount) public pure {
    require(to != address(0), unicode"无效的接收地址");
    require(amount > 0, unicode"转账金额必须大于0");
    }

    //assert
    function divide(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 result = a / b;
        assert(b != 0); // 确保除数不为0
        return result;
    }
    function checkPrice(uint256 price) public payable   {
        if (msg.value < price) {
            revert("Insufficient funds");
        }
    }

    //自定义错误
    error NotOwner();

    function onlyOwner(address owner) public view {
        if (msg.sender != owner) {
            revert NotOwner();
        }
    }

    // 简单错误（不带参数）
    error Unauthorized();

    // 带参数的错误
    error InsufficientBalance(uint256 available, uint256 required);

    // 复杂参数的错误
    error TransferFailed(address from, address to, uint256 amount, string reason);
    // 触发自定义错误
    function withdraw(uint256 amount) public pure {
        if (amount > 10000) {
            revert InsufficientBalance(1000, amount);
        }
    }

    address public owner1;

    constructor() {
        owner1 = msg.sender;
    }

    // 自定义修饰符，仅允许合约所有者调用
    modifier onlyOwner2 {
        require(msg.sender == owner1, unicode"仅合约所有者可调用");
        _;
    }

    function changeOwner(address newOwner) public onlyOwner2 {
        owner1 = newOwner;
    }

     mapping(address => uint256) public balances;

    // 自定义修饰符，检查余额是否足够
    modifier hasSufficientBalance(uint256 amount) {
        require(balances[msg.sender] >= amount, unicode"余额不足");
        _;
    }

    // 存款函数
    function deposit() public payable {
        require(msg.value > 0, unicode"存款金额必须大于0");
        balances[msg.sender] += msg.value;
    }

    // 取款函数
    function withdraw2(uint256 amount) public hasSufficientBalance(amount) {
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        assert(balances[msg.sender] >= 0); // 确保余额不为负
    }
}