// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// 引入本地文件
import "./IBank.sol";

// 引入远程文件
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

// 引入整个目录


// 引入并重命名
import { BankUser as BU } from "./BankUser.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract importDemo{

  
}
contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {}
}