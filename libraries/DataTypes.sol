// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

library DataTypes {
    enum TaskStatus {
        TODO,
        DOING,
        REVIEW,
        DONE
    }
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
}
