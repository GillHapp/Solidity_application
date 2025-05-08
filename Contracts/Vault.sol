// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Vault {
    address public owner;
    uint256 public balance;

    event Deposited(address user, uint256 amount);

    function initialize(address _owner) external {
        require(owner == address(0), "Already initialized");
        owner = _owner;
    }

    function deposit() external payable {
        require(msg.sender == owner, "Only owner can deposit");
        balance += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function getBalance() external view returns (uint256) {
        return balance;
    }

    
}
