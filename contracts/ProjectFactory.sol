// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./Projects.sol";

contract ProjectsFactory {
    Projects[] public deployedProjects;

    function createProject() public {
        Projects newProject = new Projects();
        deployedProjects.push(newProject);
    }

    function getDeployedProjects() public view returns (Projects[] memory) {
        return deployedProjects;
    }
}
