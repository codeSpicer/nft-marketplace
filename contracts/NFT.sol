// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol"; // handy library for incrementing decrementing values

contract NFT is
    ERC721URIStorage // uri storage inherits from erc721
{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds; // values of unique identifier
    address contractAddress; // address of marketplace who will handle token

    constructor(address marketplaceAddress) ERC721("Metaverse Tokens", "METT") {
        contractAddress = marketplaceAddress; // stores the address
    }

    function createToken(string memory tokenURI) public returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        setApprovalForAll(contractAddress, true); // gives market permission to transact token between users
        return newItemId;
    }
}
