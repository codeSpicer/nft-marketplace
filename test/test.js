const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NFTMarket", function () {
  it("Should create and excute market sales", async function () {
    const Market = await ethers.getContractFactory("NFTMarket")   // creates a new instance of contract
    const market = await Market.deploy()  // deploys the new instance
    await market.deployed()   // waits for the contract to be deployed
    const marketAddress = market.address // stores the address of the deployed contract 

    const NFT = await ethers.getContractFactory("NFT")    // creates instance of nft contract
    const nft = await NFT.deploy(marketAddress)   // deploys the nft contract by passing the market address
    await nft.deployed()     // waits for the contract to be deployed
    const nftContractAddress = nft.address  // address of the deployed nft contract

    let listingPrice = await market.getListingPrice() //fetches the listing price from market
    listingPrice = listingPrice.toString()

    const auctionPrice = ethers.utils.parseUnits('100' , 'ether')   // value for auction price
    
    await nft.createToken("location1")    // tokenURI passed
    await nft.createToken("location2")

    await market.createMarketItem(nftContractAddress , 1 , auctionPrice , {value: listingPrice} )
    await market.createMarketItem(nftContractAddress , 2 , auctionPrice , {value: listingPrice} )
    
    // to buy an item we will be using another account from the hardhat generated accounts 
    // to fetch the accounts we use getSigners function in ethers.js
    // the _ here means we are skiping the first address and buyersAddress will get the value of the second account
    // also the first account is used for all default tranx 
    const [_, buyerAddress] = await ethers.getSigners()

    // using the second address , here we buy an item from the market
    await market.connect(buyerAddress).createMarketSale(nftContractAddress, 1 , {value:auctionPrice})
    
    const items = await market.fetchMarketItems()
    console.log('items: ',items)

  });
});
