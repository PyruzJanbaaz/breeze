// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {Project} from "./Project.sol";

contract ProjectFactory {
    Project[] public deployedProjects;

    function createProject(string memory _title, string memory _description)
        public
    {
        Project project = new Project(msg.sender, _title, _description);
        deployedProjects.push(project);
    }

    function getDeployedProjects()
        public
        view
        returns (Project[] memory)
    {
        return deployedProjects;
    }
}
