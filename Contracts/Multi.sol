// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract TestMultiCall {
   function fun1() public view returns (uint256, uint256) {
    return (1, block.timestamp);
   }

    function fun2() public view returns (uint256, uint256) {
    return (2, block.timestamp);
   }

   //get the call data for both function 

   function getcalldata1() public pure returns (bytes memory){
    return abi.encodeWithSelector(this.fun1.selector);
   }
    
     function getcalldata2() public pure returns (bytes memory){
    return abi.encodeWithSelector(this.fun2.selector);
   }

}


contract MultiCall {
    function multiCall(address[] calldata targets, bytes[] calldata data)
        external
        view
        returns (bytes[] memory)
    {
        require(targets.length == data.length, "target length != data length");

        bytes[] memory results = new bytes[](data.length);

        for (uint256 i; i < targets.length; i++) {
            (bool success, bytes memory result) = targets[i].staticcall(data[i]);
            require(success, "call failed");
            results[i] = result;
        }

        return results;
    }
}
