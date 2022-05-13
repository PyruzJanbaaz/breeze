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
    struct Project {
        string title;
        string description;
        uint256 createDate;
        mapping(uint256 => Task) tasks;
    }
    Project project;

    constructor(address _owner) Breeze(_owner) {}

    function addNewProject(string memory _title, string memory _description)
        public
        ownerOnly
    {
        project.title = _title;
        project.description = _description;
        project.createDate = block.timestamp;
    }

    function getProjectInfo()
        public
        view
        returns (
            string memory title,
            string memory description,
            uint256 createDate
        )
    {
        return (project.title, project.description, project.createDate);
    }

    function addNewTask(
        string memory _title,
        string memory _description,
        uint256 _amount
    ) public ownerOnly {
        Task storage task = project.tasks[++taskId];
        task.assigner = owner;
        task.title = _title;
        task.description = _description;
        task.amount = _amount;
        task.status = TaskStatus.DOING;
        task.createDate = block.timestamp;
    }

    function updateTask(
        uint256 _taskId,
        string memory _title,
        string memory _description,
        uint256 _amount
    ) public ownerOnly {
        project.tasks[_taskId].title = _title;
        project.tasks[_taskId].description = _description;
        project.tasks[_taskId].amount = _amount;
        project.tasks[_taskId].updateDate = block.timestamp;
    }

    function assignTask(uint256 _taskId, address _assignee) public {
        project.tasks[_taskId].assignee = _assignee;
        project.tasks[_taskId].assigner = msg.sender;
        project.tasks[_taskId].updateDate = block.timestamp;
    }

    function changeTaskStatus(uint256 _taskId, TaskStatus _status) public {
        if (_status != TaskStatus.DONE)
            changeTaskStatusAction(_taskId, _status);
        else doneTaskStatus(_taskId);
    }

    function changeTaskStatusAction(uint256 _taskId, TaskStatus _status)
        internal
    {
        project.tasks[_taskId].status = _status;
    }

    function doneTaskStatus(uint256 _taskId) internal ownerOnly {
        changeTaskStatusAction(_taskId, TaskStatus.DONE);
    }

    function deleteTaskById(uint256 _taskId) public ownerOnly {
        delete project.tasks[_taskId];
    }

    function getTaskById(uint256 _taskId)
        public
        view
        returns (Task memory task)
    {
        return project.tasks[_taskId];
    }
}
