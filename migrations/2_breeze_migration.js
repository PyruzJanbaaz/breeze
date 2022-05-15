const Breeze = artifacts.require("Breeze");
const ArraysUtility = artifacts.require("../libraries/ArraysUtility");
const DataTypes = artifacts.require("../libraries/DataTypes");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(ArraysUtility);
  deployer.link(ArraysUtility, Breeze);
  deployer.deploy(DataTypes);
  deployer.link(DataTypes, Breeze);
  deployer.deploy(Breeze, accounts[0]);
};
