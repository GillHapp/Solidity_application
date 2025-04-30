// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC20/extensions/draft-ERC20Permit.sol";

contract MyToken is ERC20, ERC20Permit {
    constructor() ERC20("HappyGillToken", "HGK") ERC20Permit("HappyGillToken") {}

    function mint(address to, uint256 value) external {
        _mint(to, value);
    }

    // function trasrer(){
    //   permit(){}
    //   transferfrom(){}
    // }
}