// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./Breeze.sol";
import "../libraries/ArraysUtility.sol";

contract Projects is Breeze {
    using ArraysUtility for *;

    enum TaskStatus {
        TODO,
        DOING,
        REVIEW,
        DONE
    }
    uint256 taskId;
    struct Task {
        string title;
        string description;
        uint256 createDate;
        uint256 updateDate;
        uint256 amount;
        address assignee;
        address assigner;
        TaskStatus status;
    }
    uint256 projectId;
    uint256[] projectIds;
    struct Project {
        uint256 createDate;
        string title;
        mapping(uint256 => Task) tasks;
    }
    mapping(uint256 => Project) projects;

    constructor() Breeze(msg.sender) {}

    function addNewProject(string memory _title) public ownerOnly {
        Project storage project = projects[++projectId];
        project.title = _title;
        project.createDate = block.timestamp;
        projectIds.push(projectId);
    }

    function addNewTask(
        uint256 _projectId,
        string memory _title,
        string memory _description,
        uint256 _amount
    ) public ownerOnly {
        Task storage task = projects[_projectId].tasks[++taskId];
        task.assigner = owner;
        task.title = _title;
        task.description = _description;
        task.amount = _amount;
        task.status = TaskStatus.DOING;
        task.createDate = block.timestamp;
    }

    function updateTask(
        uint256 _projectId,
        uint256 _taskId,
        string memory _title,
        string memory _description,
        uint256 _amount
    ) public ownerOnly {
        projects[_projectId].tasks[_taskId].title = _title;
        projects[_projectId].tasks[_taskId].description = _description;
        projects[_projectId].tasks[_taskId].amount = _amount;
        projects[_projectId].tasks[_taskId].updateDate = block.timestamp;
    }

    function assignTask(
        uint256 _projectId,
        uint256 _taskId,
        address _assignee
    ) public {
        projects[_projectId].tasks[_taskId].assignee = _assignee;
        projects[_projectId].tasks[_taskId].assigner = msg.sender;
        projects[_projectId].tasks[_taskId].updateDate = block.timestamp;
    }

    function changeTaskStatus(
        uint256 _projectId,
        uint256 _taskId,
        TaskStatus _status
    ) public {
        if (_status != TaskStatus.DONE)
            changeTaskStatusAction(_projectId, _taskId, _status);
        else doneTaskStatus(_projectId, _taskId);
    }

    function changeTaskStatusAction(
        uint256 _projectId,
        uint256 _taskId,
        TaskStatus _status
    ) internal {
        projects[_projectId].tasks[_taskId].status = _status;
    }

    function doneTaskStatus(uint256 _projectId, uint256 _taskId)
        internal
        ownerOnly
    {
        changeTaskStatusAction(_projectId, _taskId, TaskStatus.DONE);
    }

    function deleteTaskById(uint256 _projectId, uint256 _taskId)
        public
        ownerOnly
    {
        delete projects[_projectId].tasks[_taskId];
    }

    function getProjectById(uint256 _projectId)
        public
        view
        returns (
            uint256 id,
            string memory title,
            uint256 createDate
        )
    {
        return (
            _projectId,
            projects[_projectId].title,
            projects[_projectId].createDate
        );
    }

    function getTaskById(uint256 _projectId, uint256 _taskId)
        public
        view
        returns (Task memory task)
    {
        return projects[_projectId].tasks[_taskId];
    }

    function getProjectsCount() public view returns (uint256 count) {
        return projectIds.length;
    }

    function deleteProject(uint256 _projectId) public ownerOnly {
        delete projects[_projectId];
        deleteProjectIdByShifting(_projectId);
    }

    function getProjectIdByIndex(uint256 _index)
        public
        view
        returns (uint256 id)
    {
        return projectIds.findValueByIndex(_index);
    }

    function deleteProjectIdByShifting(uint256 _projectId) internal ownerOnly {
        uint256 _index = projectIds.findIndexByValue(_projectId);
        projectIds.deleteItemByIndex(_index);
    }
}
