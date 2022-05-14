// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./Project.sol";

contract ProjectFactory {
    Project[] public deployedProjects;

    function createProject() public {
        Project newProject = new Project(msg.sender);
        deployedProjects.push(newProject);
    }

    function getDeployedProjects() public view returns (Project[] memory) {
        return deployedProjects;
    }
}
