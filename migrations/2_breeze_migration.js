const Breeze = artifacts.require("Breeze");
const ArraysUtility = artifacts.require("../libraries/ArraysUtility");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(ArraysUtility);
  deployer.link(ArraysUtility, Breeze);
  deployer.deploy(Breeze, accounts[0]);
};