const Project = artifacts.require("Project");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(Project, accounts[0]);
};
