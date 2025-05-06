// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract TestContract {
    address public owner;
    uint256 public foo;

    constructor(address _owner, uint256 _foo) payable {
        owner = _owner;
        foo = _foo;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}




// This is the older way of doing it using assembly
contract FactoryAssembly {
    event Deployed(address addr, uint256 salt);
    function getBytecode(address _owner, uint256 _foo)
        public
        pure
        returns (bytes memory)
    {
        bytes memory bytecode = type(TestContract).creationCode;

        return abi.encodePacked(bytecode, abi.encode(_owner, _foo));
    }

//  0x2bF4e96614b1FB5c4c5EC8ee36CB4560e9884B24
// 0x2bF4e96614b1FB5c4c5EC8ee36CB4560e9884B24


    function getAddress(bytes memory bytecode, uint256 _salt)
        public
        view
        returns (address)
    {
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff), address(this), _salt, keccak256(bytecode)
            )
        );

        // NOTE: cast last 20 bytes of hash to address
        return address(uint160(uint256(hash)));
    }




    // 3. Deploy the contract
    function deploy(bytes memory bytecode, uint256 _salt) public payable {
        address addr;
        assembly {
            addr :=
                create2(
                    callvalue(),
                    add(bytecode, 0x20),
                    mload(bytecode), // Load the size of code contained in the first 32 bytes
                    _salt // Salt from function arguments
                )

            if iszero(extcodesize(addr)) { revert(0, 0) }
        }

        emit Deployed(addr, _salt);
    }
}

