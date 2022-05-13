// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./Breeze.sol";
import "../libraries/ArraysUtility.sol";

contract Teams is Breeze {
    using ArraysUtility for *;

    uint256 teamId;
    struct Team {
        uint256 projectId;
        uint256 createDate;
        string title;
        address[] teamMembers;
    }
    mapping(uint256 => Team) teams;
    mapping(uint256 => uint256[]) projectTeams;

    constructor() Breeze(msg.sender) {}

    function addNewTeam(uint256 _projectId, string memory _title)
        public
        ownerOnly
    {
        Team storage team = teams[++teamId];
        team.title = _title;
        team.projectId = _projectId;
        team.createDate = block.timestamp;
        projectTeams[_projectId].push(teamId);
    }

    function getTeamById(uint256 _teamId)
        public
        view
        returns (
            uint256 projectId,
            uint256 createDate,
            string memory title
        )
    {
        return (
            teams[_teamId].projectId,
            teams[_teamId].createDate,
            teams[_teamId].title
        );
    }

    function getTeamIdByProjectId(uint256 _projectId)
        public
        view
        returns (uint256[] memory _teamIds)
    {
        return projectTeams[_projectId];
    }

    function updateTeamTitle(uint256 _teamId, string memory _title)
        public
        ownerOnly
    {
        teams[_teamId].title = _title;
    }

    function deleteTeam(uint256 _projectId, uint256 _temaId) public ownerOnly {
        delete teams[_temaId];
        deleteTeamByShifting(_projectId, _temaId);
    }

    function deleteTeamByShifting(uint256 _projectId, uint256 _temaId)
        internal
        ownerOnly
    {
        uint256[] storage teamIds = projectTeams[_projectId];
        uint256 _index = teamIds.findIndexByValue(_temaId);
        teamIds.deleteItemByIndex(_index);
    }

    function getTeamsCount(uint256 _projectId)
        public
        view
        returns (uint256 count)
    {
        return projectTeams[_projectId].length;
    }

    function assignUserToTeam(uint256 _teamId, address _userAddress)
        public
        ownerOnly
    {
        require(
            teams[_teamId].teamMembers.length <= 10,
            "The maximum number of team members is 10!"
        );
        if (teams[_teamId].teamMembers.length > 0)
            require(
                teams[_teamId].teamMembers.findIndexByValue(_userAddress) >= 0,
                "User is alredy exist!"
            );
        teams[_teamId].teamMembers.push(_userAddress);
    }

    function unassignUserFromTeam(uint256 _teamId, address _userAddress)
        public
        ownerOnly
    {
        uint256 _index = teams[_teamId].teamMembers.findIndexByValue(
            _userAddress
        );
        teams[_teamId].teamMembers.deleteItemByIndex(_index);
    }

    function getTeamMembersCount(uint256 _teamId)
        public
        view
        returns (uint256 count)
    {
        return teams[_teamId].teamMembers.length;
    }
}
