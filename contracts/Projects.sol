// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import './Breeze.sol';
import '../libraries/ArraysUtility.sol';

contract Projects is Breeze {

    using ArraysUtility for *;

    uint  projectId;
    uint[] projectIds;
    struct Project{
        uint createDate;
        string title;
    }
    mapping(uint => Project) projects;

	constructor() Breeze(msg.sender) {
	}

    function addNewProject(string memory _title) public {
        Project storage project = projects[++projectId];
        project.title = _title;
        project.createDate = block.timestamp;
        projectIds.push(projectId);
    }

    function getProjectById(uint _projectId) public view returns(Project memory project){
      return  projects[_projectId];
    }

    function getProjectsCount() public view returns(uint count){
        return projectIds.length;
    }

    function deleteProject(uint _projectId) public ownerOnly{
		delete projects[_projectId];
		deleteProjectIdByShifting(_projectId);
	}

    function findProjectIdByIndex(uint _index) public view returns(uint projectId){
        return projectIds.findIdByIndex(_index);
    }

	function deleteProjectIdByShifting(uint _projectId) internal ownerOnly{
		uint _index = projectIds.findIndexById(_projectId);
        projectIds.deleteItemByIndex(_index);
	}

}