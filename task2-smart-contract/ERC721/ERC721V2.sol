// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


//Ownable可以去掉 这样每个连上这个合约的用户  都可以mint NFT了  如果加了  Ownable只有这个合约开发者可以铸造NFT
contract ERC721LIN is ERC721URIStorage, Ownable {


    //构造函数
    constructor(address initialOwner) ERC721("ERC721", "LIN") Ownable(initialOwner) {}

    //铸造NFT
    function mint(address _to, uint256 _tokenId, string calldata _uri) external onlyOwner{
        _mint(_to, _tokenId);
        _setTokenURI(_tokenId, _uri);
    }
}

