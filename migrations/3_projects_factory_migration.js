const ProjectsFactory = artifacts.require('ProjectsFactory')

module.exports = function (deployer) {
  deployer.deploy(ProjectsFactory)
}
