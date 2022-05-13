// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "./Breeze.sol";

contract Migrations is Breeze {
    uint256 public last_completed_migration;

    constructor() Breeze(msg.sender) {}

    function setCompleted(uint256 completed) public ownerOnly {
        last_completed_migration = completed;
    }
}
