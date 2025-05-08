// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract DeployWithCreate2{
    address public owner;

    constructor(address _owner){
        owner = _owner;
    }

}

contract FactoryContract {

    event CreatedContract (address deployedAddress);

    function deployContract(uint _salt) external {
        DeployWithCreate2 contract1 = new DeployWithCreate2{salt: bytes32(_salt)}(msg.sender);
        // emit the event 
        emit CreatedContract(address(contract1));
        // return the deployed contract's address
    }

    function getaddress(bytes memory bytecode, uint _salt) public view returns(address){
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff), address(this), _salt, keccak256(bytecode)
            ));

            return address(uint160(uint256(hash)));

    }
}