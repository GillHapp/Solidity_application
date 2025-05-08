// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Logic {
    address public owner;
    uint256 public value;

    function initialize(address _owner, uint256 _value) external {
        require(owner == address(0), "Already initialized");
        owner = _owner;
        value = _value;
    }

    function updateValue(uint256 _newValue) external {
        require(msg.sender == owner, "Not the owner");
        value = _newValue;
    }
}

