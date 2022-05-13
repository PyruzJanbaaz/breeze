const Projects = artifacts.require("Projects");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(Projects, accounts[0]);
};
