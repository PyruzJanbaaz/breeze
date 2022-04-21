// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import './Breeze.sol';

contract Teams is Breeze {

    uint  teamId;
    struct Team{
        uint projectId;
        uint createDate;
        string title;
    }
    mapping(uint => Team) teams;
    mapping(uint => uint[]) project_team;

    constructor() Breeze(msg.sender){
	}

    function addNewTeam(uint _projectId, string memory _title) public {
        Team storage team = teams[++teamId];
        team.title = _title;
        team.projectId = _projectId;
        team.createDate = block.timestamp;
        project_team[_projectId].push(teamId);
    }

    function getTeamById(uint _teamId) public view returns(Team memory team){
      return  teams[_teamId];
    }
    
    function getTeamIdByProjectId(uint _projectId) public view returns(uint[] memory _teamIds){
        return project_team[_projectId];
    }

    function updateTeamTitle(uint _teamId,string memory _title) public ownerOnly{
        teams[_teamId].title = _title;
    }

    function findTeamIndexById(uint[] memory _teamIds, uint _teamId) internal view returns(uint) {
        uint index = 0;
        while (_teamIds[index] != _teamId) {
            index++;
        }
        return index;
    }

    function deleteTeam(uint _projectId, uint _temaId) public ownerOnly {
        delete teams[_temaId];
        deleteTeamByShifting(_projectId, _temaId);
    }

    function deleteTeamByShifting(uint _projectId, uint _temaId) internal ownerOnly {
        uint[] storage teamIds = project_team[_projectId];
        uint  _index = findTeamIndexById(teamIds, _temaId);
        for(uint i = _index; i < teamIds.length -1; i++){
			teamIds[i] = teamIds[i + 1];
		}
		teamIds.pop();
    }

    function getTeamsCount(uint _projectId) public view returns(uint count){
        return project_team[_projectId].length;
    } 

}