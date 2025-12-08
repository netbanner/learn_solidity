// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;


contract BeggingContract{


    address public owner;
    uint256 public totalDonations;
    uint256 public donationCount;

    // 捐赠时间限制（可选功能）
    uint256 public donationStartTime;
    uint256 public donationEndTime;
    bool public hasTimeLimit;
    
    // Mapping 记录每个捐赠者的捐赠金额
    mapping(address => uint256) public donations;
    // 记录所有捐赠者地址（用于排行榜）
    address[] public donors;
    // 记录地址是否已经捐赠过
    mapping(address => bool) public hasDonated;


    constructor(){
        owner = msg.sender;
        hasTimeLimit = false;
    }

     modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

        // 获取合约信息
    function getContractInfo() public view returns (
        address contractOwner,
        uint256 totalDonationAmount,
        uint256 totalDonors,
        uint256 contractBalance,
        bool timeLimitEnabled
    ) {
        return (
            owner,
            totalDonations,
            donationCount,
            address(this).balance,
            hasTimeLimit
        );
    }

      modifier withinTimeLimit() {
        if (hasTimeLimit) {
            require(
                block.timestamp >= donationStartTime && block.timestamp <= donationEndTime,
                "Donation period is not active"
            );
        }
        _;
    }
    //捐款时间
    event DonationReceived(address indexed donor, uint256 amount, uint256 timestamp);
    //提现事件
    event Withdrawal(address indexed owner, uint256 amount,uint256 timstam);

     event TimeLimitSet(uint256 startTime, uint256 endTime);

    function donate()payable  public withinTimeLimit {
        require(msg.value > 0, "Donation amount must be greater than 0");

        if(!hasDonated[msg.sender]){
            donors.push(msg.sender);
            hasDonated[msg.sender] = true;
            donationCount++;
        }
            
        // 记录捐赠金额
        donations[msg.sender] += msg.value;
        totalDonations += msg.value;
        emit DonationReceived(msg.sender, msg.value, block.timestamp);
    }

    //获取捐款金额
    function getDonateAmount(address donor) public view returns(uint256){
        return donations[donor];
    }

    // 合约所有者提取所有资金
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");
        
        // 使用 call 代替 transfer 
        (bool success, ) = payable(owner).call{value: balance}("");
        require(success, "Withdrawal failed");
        
        emit Withdrawal(owner, balance, block.timestamp);
    }

    // 获取合约余额
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    // 获取捐赠者数量
    function getDonorsCount() public view returns (uint256) {
        return donors.length;
    }
    
    // 获取所有捐赠者（用于调试）
    function getAllDonors() public view returns (address[] memory) {
        return donors;
    }

     // 设置时间限制（可选功能）
    function setTimeLimit(uint256 _startTime, uint256 _endTime) public onlyOwner {
        require(_startTime < _endTime, "Start time must be before end time");
        require(_startTime > block.timestamp, "Start time must be in the future");
        
        donationStartTime = _startTime;
        donationEndTime = _endTime;
        hasTimeLimit = true;
        
        emit TimeLimitSet(_startTime, _endTime);
    }
    
    // 移除时间限制
    function removeTimeLimit() public onlyOwner {
        hasTimeLimit = false;
    }

     //快速排序 代码执行顺序从上到下
    function _quickSort(address[] memory addrs, uint256[] memory amounts,int256 left,int256 right) internal pure {
        int256 i = left;
        int256 j = right;
        if(i==j) return;

        uint256 privot = amounts[uint256(left+(right-left)/2)];
        while (i<=j){
            while(amounts[uint256(i)]>privot){
                i++;
            }
            while(amounts[uint256(j)]<privot){
                j--;
            }
            
            if(i<=j){
                // 交换金额
                (amounts[uint256(i)], amounts[uint256(j)]) = (amounts[uint256(j)], amounts[uint256(i)]);
                // 交换地址
                (addrs[uint256(i)], addrs[uint256(j)]) = (addrs[uint256(j)], addrs[uint256(i)]);
            }
            i++;
            j--;

        }

    }

    //获取排行榜
    function getTop() public view returns(address[] memory topAddresses,uint256[] memory topAmounts){

        uint256 arraySize = donors.length < 3 ? donors.length : 3;

        topAddresses = new address[](arraySize);
        topAmounts = new uint256[](arraySize);
        
        if (donors.length == 0) {
            return (topAddresses, topAmounts);
        }

            // 创建临时数组用于排序
        address[] memory tempDonors = new address[](donors.length);
        uint256[] memory tempAmounts = new uint256[](donors.length);
        
        for (uint256 i = 0; i < donors.length; i++) {
            tempDonors[i] = donors[i];
            tempAmounts[i] = donations[donors[i]];
        }
        _quickSort(tempDonors, tempAmounts, int256(0), int256(tempAmounts.length - 1));

         // 返回前3名
        for (uint256 i = 0; i < arraySize; i++) {
            topAddresses[i] = tempDonors[i];
            topAmounts[i] = tempAmounts[i];
        }
        
        return (topAddresses, topAmounts);

    }

     // 回退函数 - 允许直接发送以太币到合约
    receive() external payable {
        donate();
    }
    

    
}