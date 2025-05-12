// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Proxy {
    event Deploy(address);

    receive() external payable {}

    function deploy(bytes memory _code)
        external
        payable
        returns (address addr)
    {
        assembly {
            addr := create(callvalue(), add(_code, 0x20), mload(_code))
        }
        // return address 0 on error
        require(addr != address(0), "deploy failed");

        emit Deploy(addr);
    }

    function execute(address _target, bytes memory _data) external payable {
        (bool success,) = _target.call{value: msg.value}(_data);
        require(success, "failed");
    }
}

contract TestContract1 {
    address public owner;

    function setOwner(address _owner) public {
        // require(msg.sender == owner, "not owner");
        owner = _owner;
    }
}


contract Helper {
    function getBytecode1() external pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract1).creationCode;
        return bytecode;
    }


    function getCalldata(address _owner) external pure returns (bytes memory) {
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
}


// 0x476915eBDb08CaeeDf98953D7c940146Ff5BAA94