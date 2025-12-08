// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721,ERC721URIStorage ,Ownable{

    uint256 private _nextTokenId;
    constructor(
        string memory name,
        string memory symbol,
        address initialOwner
    ) ERC721(name, symbol) Ownable(initialOwner) {}

    function mintNFT(address recipient, string memory uri)
        public
        returns (uint256)
    {
        uint256 tokenId = _nextTokenId++;
        _safeMint(recipient, tokenId);
        _setTokenURI(tokenId, uri);
        return tokenId;
    }

    // 必需的函数覆盖
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
