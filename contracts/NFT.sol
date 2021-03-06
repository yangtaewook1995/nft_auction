// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFT is ERC721URIStorage {
    address public owner;
    uint256 public tokenCap;

    constructor(uint256 cap) ERC721("TokenName", "SYM") {
        owner = msg.sender;
        tokenCap = cap;
    }

    function transferOwnership(address newOwner) public returns (bool) {
        require(msg.sender == owner, "NFT : caller must owner");
        require(
            newOwner != address(0),
            "NFT : newOwner should not be address(0)"
        );

        owner = newOwner;

        return true;
    }

    function createToken(
        address account,
        uint256 tokenId,
        string memory tokenURI
    ) public returns (uint256) {
        require(msg.sender == owner, "NFT : only owner can create NFT");
        require(tokenId != 0, "NFT : tokenId starts 1");
        require(tokenId <= tokenCap, "NFT : too many token. tokenCap is 100");

        _mint(account, tokenId);
        _setTokenURI(tokenId, tokenURI);
        return tokenId;
    }

    function burnToken(uint256 tokenId) public returns (uint256) {
        require(
            msg.sender == ownerOf(tokenId),
            "NFT : cannot burn other's token"
        );
        _burn(tokenId);
        return tokenId;
    }
}
