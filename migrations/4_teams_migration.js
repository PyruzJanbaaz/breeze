const Teams = artifacts.require("Teams");

module.exports = function (deployer) {
  deployer.deploy(Teams);
};
