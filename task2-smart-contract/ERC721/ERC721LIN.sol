// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@5.0.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@5.0.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@5.0.0/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts@5.0.0/access/Ownable.sol";


//Ownable可以去掉 这样每个连上这个合约的用户  都可以mint NFT了  如果加了  Ownable只有这个合约开发者可以铸造NFT
contract ERC721LIN is ERC721, ERC721URIStorage, ERC721Burnable, Ownable {
    constructor(address initialOwner)
    ERC721("MyToken", "MTK_NFT")
    Ownable(initialOwner)
    {}

    //铸造NFT
    function safeMint(address to, uint256 tokenId, string memory uri)
    public
    onlyOwner
    {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.
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
