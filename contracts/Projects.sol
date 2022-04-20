// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Projects {

    address public owner;
    uint  projectId;
    uint[] projectIds;
    struct Project{
        uint createDate;
        string title;
    }
    mapping(uint => Project) projects;

	constructor(){
		owner = msg.sender;
	}

	modifier ownerOnly(){
		require (msg.sender == owner , "You do not have permission for this action!");
		_;
	}

    function addNewProject(string memory _title) public {
        Project storage project = projects[++projectId];
        project.title = _title;
        project.createDate = block.timestamp;
        projectIds.push(projectId);
    }

    function findProjectIndexById(uint _projectId)internal view returns(uint) {
        uint index = 0;
        while (projectIds[index] != _projectId) {
            index++;
        }
        return index;
    }

    function findProjectIdByIndex(uint _projectIndex) public view returns(uint projectId){
        return projectIds[_projectIndex];
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

	function deleteProjectIdByShifting(uint _projectId) internal ownerOnly{
		uint _index = findProjectIndexById(_projectId);
		require (_index < projectIds.length , "Array index out of bound!");
		for(uint i = _index; i < projectIds.length -1; i++){
			projectIds[i] = projectIds[i + 1];
		}
		projectIds.pop();
	}

}