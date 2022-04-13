// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Teams {

    uint  teamId = 1;
    uint[] teamIds;
    struct Team{
        uint projectId;
        uint createDate;
        string title;
    }
    mapping(uint => Team) teams;
    mapping(uint => uint[]) project_team;

    function addNewTeam(uint _projectId, string memory _title) public {
        Team storage team = teams[teamId];
        team.title = _title;
        team.projectId = _projectId;
        team.createDate = block.timestamp;
        project_team[_projectId].push(teamId++);
    }

    function getTeamById(uint _teamId) public view returns(Team memory team){
      return  teams[_teamId];
    }
    
    function getTeamIdByProjectId(uint _projectId) public view returns(uint[] memory _teamIds){
        return project_team[_projectId];
    }
}