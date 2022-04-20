// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Teams {

    address public owner;
    uint  teamId;
    uint[] teamIds;
    struct Team{
        uint projectId;
        uint createDate;
        string title;
    }
    mapping(uint => Team) teams;
    mapping(uint => uint[]) project_team;

    constructor(){
		owner = msg.sender;
	}

	modifier ownerOnly(){
		require (msg.sender == owner , "You do not have permission for this action!");
		_;
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

    function findTeamIndexById(uint _teamId)internal view returns(uint) {
        uint index = 0;
        while (teamIds[index] != _teamId) {
            index++;
        }
        return index;
    }    

    function findTeamIdByIndex(uint _teamIndex) public view returns(uint teamId){
        return teamIds[_teamIndex];
    }

    function getTeamsCount() public view returns(uint count){
        return teamIds.length;
    }

    function deleteTeam(uint _teamId) public ownerOnly{
		delete teams[_teamId];
		deleteTeamIdByShifting(_teamId);
	}

	function deleteTeamIdByShifting(uint _teamId) internal ownerOnly{
		uint _index = findTeamIndexById(_teamId);
		require (_index < teamIds.length , "Array index out of bound!");
		for(uint i = _index; i < teamIds.length -1; i++){
			teamIds[i] = teamIds[i + 1];
		}
		teamIds.pop();
	}

    function updateTeamTitle(uint _teamId,string memory _title) public ownerOnly{
        teams[_teamId].title = _title;
    }

}