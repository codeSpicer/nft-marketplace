// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; // set token uri functionality
import "@openzeppelin/contracts/utils/Counters.sol"; // handy library for incrementing decrementing values

contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds; // total number of unique identifier
    address contractAddress; // address of marketplace who will handle nft

    constructor(address marketplaceAddress) ERC721("Metaverse Tokens", "METT") {
        contractAddress = marketplaceAddress; // stores the address of the marketplace
    }

    function createToken(string memory tokenURI) public returns (uint256) {
        _tokenIds.increment(); // to count the number of tokens created
        uint256 newItemId = _tokenIds.current(); // gets the value of tokenids created so it can pass next value in series

        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI); // available from ERC721URIStorage
        setApprovalForAll(contractAddress, true); // can call transferFrom or safeTransferFrom
        return newItemId; // for client
    }
}
