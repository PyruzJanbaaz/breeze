// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {Project} from "./Project.sol";
import "../libraries/ArraysUtility.sol";

contract ProjectFactory {
    using ArraysUtility for *;
    mapping(string => Project) deployedProjects;

    function createProject(string memory _key) public {
        Project project = new Project(_key, msg.sender);
        require(
            keccak256(
                abi.encodePacked(deployedProjects[_key].getProjectKey())
            ) != keccak256(abi.encodePacked(_key)),
            "Project key is duplicated!"
        );
        deployedProjects[_key] = project;
    }

    function getDeployedProjects(string memory _key)
        public
        view
        returns (Project project)
    {
        return deployedProjects[_key];
    }
}
