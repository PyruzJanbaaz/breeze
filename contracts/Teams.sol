// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import './Breeze.sol';
import '../libraries/ArraysUtility.sol';

contract Teams is Breeze {

    using ArraysUtility for *;

    uint teamId;
    struct Team{
        uint projectId;
        uint createDate;
        string title;
        address[] teamMembers;
    }
    mapping(uint => Team) teams;
    mapping(uint => uint[]) projectTeams;

    constructor() Breeze(msg.sender){
	}

    function addNewTeam(uint _projectId, string memory _title) public {
        Team storage team = teams[++teamId];
        team.title = _title;
        team.projectId = _projectId;
        team.createDate = block.timestamp;
        projectTeams[_projectId].push(teamId);
    }

    function getTeamById(uint _teamId) public view returns(uint projectId, uint createDate, string memory title){
      return  (teams[_teamId].projectId , teams[_teamId].createDate ,teams[_teamId].title);
    }
    
    function getTeamIdByProjectId(uint _projectId) public view returns(uint[] memory _teamIds){
        return projectTeams[_projectId];
    }

    function updateTeamTitle(uint _teamId,string memory _title) public ownerOnly{
        teams[_teamId].title = _title;
    }

    function deleteTeam(uint _projectId, uint _temaId) public ownerOnly {
        delete teams[_temaId];
        deleteTeamByShifting(_projectId, _temaId);
    }

    function deleteTeamByShifting(uint _projectId, uint _temaId) internal ownerOnly {
        uint[] storage teamIds = projectTeams[_projectId];
		uint _index = teamIds.findIndexByValue(_temaId);
        teamIds.deleteItemByIndex(_index);
    }

    function getTeamsCount(uint _projectId) public view returns(uint count){
        return projectTeams[_projectId].length;
    } 

    function assignUserToTeam(uint _teamId, address _userAddress) public ownerOnly{
		require (teams[_teamId].teamMembers.length <= 10 , "The maximum number of team members is 10!");  
        if(teams[_teamId].teamMembers.length > 0)
            require (teams[_teamId].teamMembers.findIndexByValue(_userAddress) >= 0 , "User is alredy exist!");  
        teams[_teamId].teamMembers.push(_userAddress);
    }

    function unassignUserFromTeam(uint _teamId, address _userAddress) public ownerOnly{
        uint _index = teams[_teamId].teamMembers.findIndexByValue(_userAddress);
        teams[_teamId].teamMembers.deleteItemByIndex(_index);
    }

    function getTeamMembersCount(uint _teamId) public view returns(uint count) {
        return teams[_teamId].teamMembers.length;
    }

}