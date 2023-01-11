require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");
//require("dotenv").config();
let secret = require("./secret");

module.exports = {
  solidity: "0.8.17",
  networks: {
    GOERLI: {
      url: secret.urlgo,
      accounts: [secret.key] 
    },
    MATIC: {
      url: secret.urlmum,
      accounts: [secret.key] 
    }
  },
  etherscan: {
    apiKey: {
      polygonMumbai: secret.MumApiKey,
      goerli: secret.GoApiKey
    },
  }
};

