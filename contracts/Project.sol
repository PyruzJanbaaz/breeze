// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./Breeze.sol";
import "../libraries/ArraysUtility.sol";
import {DataTypes} from "../libraries/DataTypes.sol";

contract Project is Breeze {
    using ArraysUtility for *;
    using DataTypes for *;
    uint256 taskId;
    DataTypes.Project project;
    string public key;

    constructor(string memory _key,address _owner) Breeze(_owner) {
        key = _key;
    }

    function getProjectKey() public view returns(string memory projectKey) {
        return key;
    }

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    function contribute() external payable {
        require(msg.value > 0, "No Ether were sent.");
        emit Received(msg.sender, msg.value);
    }

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
        DataTypes.Task storage task = project.tasks[++taskId];
        task.assigner = owner;
        task.title = _title;
        task.description = _description;
        task.amount = _amount;
        task.status = DataTypes.TaskStatus.DOING;
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

    function changeTaskStatus(uint256 _taskId, DataTypes.TaskStatus _status)
        public
    {
        if (_status != DataTypes.TaskStatus.DONE)
            changeTaskStatusAction(_taskId, _status);
        else doneTaskStatus(_taskId);
    }

    function changeTaskStatusAction(
        uint256 _taskId,
        DataTypes.TaskStatus _status
    ) internal {
        project.tasks[_taskId].status = _status;
    }

    function doneTaskStatus(uint256 _taskId) internal ownerOnly {
        changeTaskStatusAction(_taskId, DataTypes.TaskStatus.DONE);
        address payable recipient = payable(project.tasks[_taskId].assignee);
        (bool sent, ) = recipient.call{value: project.tasks[_taskId].amount}(
            ""
        );
        require(sent, "failed to pay memebr's ETH");
    }

    function deleteTaskById(uint256 _taskId) public ownerOnly {
        delete project.tasks[_taskId];
    }

    function getTaskById(uint256 _taskId)
        public
        view
        returns (DataTypes.Task memory task)
    {
        return project.tasks[_taskId];
    }
}
