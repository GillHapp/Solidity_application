// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract EtherWallet{
    address payable public owner;

    constructor(){
        owner = payable(msg.sender);
    }

    receive() external payable { }

    function withdraw() external {
        require(owner == msg.sender, "only owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }

}