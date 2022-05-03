// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import './Breeze.sol';
import '../libraries/ArraysUtility.sol';

contract Projects is Breeze {

    using ArraysUtility for *;

    enum TaskStatus {
        TODO,
        DOING,
        REVIEW,
        DONE
    }
    struct Task {
        string title;
        string description;
        uint createDate;
        address assignee;
        address assigner;
        TaskStatus taskStatus;
    }
    uint  projectId;
    uint[] projectIds;    
    struct Project{
        uint createDate;
        string title;
        mapping(uint => Task) tasks;
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

    function getProjectById(uint _projectId) public view returns(uint id, string memory title, uint createDate){
      return  (_projectId, projects[_projectId].title , projects[_projectId].createDate);
    }

    function getProjectsCount() public view returns(uint count){
        return projectIds.length;
    }

    function deleteProject(uint _projectId) public ownerOnly{
		delete projects[_projectId];
		deleteProjectIdByShifting(_projectId);
	}

    function getProjectIdByIndex(uint _index) public view returns(uint id){
        return projectIds.findValueByIndex(_index);
    }

	function deleteProjectIdByShifting(uint _projectId) internal ownerOnly{
		uint _index = projectIds.findIndexByValue(_projectId);
        projectIds.deleteItemByIndex(_index);
	}

}