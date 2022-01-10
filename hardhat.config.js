require("@nomiclabs/hardhat-waffle");

const fs = require("fs")
const projectId = "9e16fb3533274ea2adc49a665c0f1feb";
const privateKey = fs.readFileSync(".secret").toString()

module.exports = {
  networks:{
    hardhat: {chainId: 1337},
    mumbai:{url:"https://polygon-mumbai.infura.io/v3/${projectId}"},
    mainnet:{url: "https://polygon-mainnet.infura.io/v3/${projectId}"}
  },
  solidity: "0.8.4",
};
