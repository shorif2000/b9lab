var ConvertLib = artifacts.require("./ExchangeShop.sol");
var MetaCoin = artifacts.require("./Remittance.sol");

module.exports = function(deployer, networks, accounts) {
  deployer.deploy(ExchangeShop);
  deployer.link(ExchangeShop, Remittance);
  deployer.deploy(Remittance, accounts[0], accounts[1], accounts[2]);
};
