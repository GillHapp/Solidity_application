// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract HappyNft is ERC721, ERC721URIStorage, Ownable{

        uint256 private nextTokenId;


     constructor(address initialOwner)
        ERC721("HappyNft", "HNFT")
        Ownable(initialOwner){}


        
    function safeMint(address to, string memory uri) public onlyOwner returns (uint256) {
        uint256 _tokenId = nextTokenId++;
        _safeMint(to, _tokenId);
        _setTokenURI(_tokenId, uri);
        return _tokenId;
    }

// mint
// sell (listing => marketplace)
// buy (new user)





     function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }


}