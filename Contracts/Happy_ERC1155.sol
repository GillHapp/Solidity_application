// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {ERC1155Supply} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import {ERC1155URIStorage} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC1155, ERC1155Supply, ERC1155URIStorage, Ownable {
    constructor(address initialOwner) ERC1155("") Ownable(initialOwner) {}

    // function setURI(string memory newuri) public onlyOwner {
    //     _setURI(newuri); // sets base URI (optional if using URIStorage per token)
    // }

    function mint(
        address account,
        uint256 id,
        uint256 amount,
        string memory tokenURI,
        bytes memory data
    ) public onlyOwner {
        _mint(account, id, amount, data);
        _setURI(id, tokenURI); // set URI for that specific token
    }

// selling 
// buy 

    //  function transferFrom(
    //     address from,
    //     address to,
    //     uint256 id,
    //     uint256 amount
    // ) public {
    //     require(
    //         from == msg.sender || isApprovedForAll(to, msg.sender),
    //         "MyToken: caller is not token owner nor approved"
    //     );

    //     safeTransferFrom(from, to, id, amount, "");
    // }




    // Required overrides
    function uri(uint256 id)
        public
        view
        override(ERC1155, ERC1155URIStorage)
        returns (string memory)
    {
        return super.uri(id);
    }

    function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._update(from, to, ids, values);
    }
}
