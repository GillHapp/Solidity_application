// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "./Vault.sol";

contract VaultFactory {
    address public immutable implementation;

    event VaultCreated(address newVault, address owner);

    constructor() {
        implementation = address(new Vault()); // deploy main logic once
    }

    function createVault() external returns (address) {
        address clone = Clones.clone(implementation); // create minimal proxy
        Vault(clone).initialize(address(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2)); // initialize state
        emit VaultCreated(clone, msg.sender);
        return clone;
    }
    
}
