// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/proxy/Clones.sol";
import "./Logic.sol";

contract ProxyFactory {
    address public logicImplementation;
    address[] public allClones;

    constructor(address _logic) {
        logicImplementation = _logic;
    }

    function createClone(uint256 _value) external returns (address) {
        address clone = Clones.clone(logicImplementation);
        Logic(clone).initialize(msg.sender, _value);
        allClones.push(clone);
        return clone;
    }

    function getClones() external view returns (address[] memory) {
        return allClones;
    }

    // get value 

    
}



