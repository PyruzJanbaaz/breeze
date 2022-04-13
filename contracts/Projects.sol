// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Projects {

    uint  projectId;
    uint[] projectIds;
    struct Project{
        uint createDate;
        string title;
    }
    mapping(uint => Project) projects;

    function addNewProject(string memory _title) public {
        Project storage project = projects[projectId];
        project.title = _title;
        project.createDate = block.timestamp;
        projectIds.push(projectId++);
    }

    function getProjectById(uint _projectId) public view returns(Project memory project){
      return  projects[_projectId];
    }
    
}