// SPDX-License-Identifier: UNLICENSED 
pragma solidity ^0.7.0;

contract Proxy {

   function setImplementation(address _impl) external {
    bytes32 IMPLEMENTATION_SLOT = keccak256(abi.encodePacked("my.proxy.implementation"));// slot 32 bytes
    assembly {
     sstore(IMPLEMENTATION_SLOT, _impl)
    }
}
    // Get the address of the logic
    function getImplementation() external view returns (address impl) {
        bytes32 IMPLEMENTATION_SLOT = keccak256(abi.encodePacked("my.proxy.implementation"));
        assembly {

            impl := sload(IMPLEMENTATION_SLOT)
        }
    }
}
