// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract FundMe {

    uint public number;
    uint256 public miniEth = 0.01*1e18;
    address[] public funders; 
    mapping(address => uint256) public addressToAmountFunded;

    address public owner;
    constructor(){
        owner = msg.sender;
    }

    function fund() public payable  {

    
        number = 5;
        // Want to be able to set a minimum fund amount in ETH
        // 1. How do we send ETH to this contract?
        // 1e18 == 1 * 10 ** 18 == 1000000000000000000
        require(msg.value>=miniEth,"Didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    modifier onlyOwner{
    require(msg.sender == owner, "Sender is not owner!");
        _;
    }


    function withdraw() public onlyOwner {
        /* starting index, ending index, step amount */
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            // code
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //重组数组
        funders = new address[](0);

        //transfer
        payable(msg.sender).transfer(address(this).balance);

        //send
        bool sendSuccess = payable (msg.sender).send(address(this).balance);
        require(sendSuccess,"send failed");
        //call
        (bool callSuccess, ) =  payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
}