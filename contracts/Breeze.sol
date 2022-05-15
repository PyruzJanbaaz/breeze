// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Breeze {
    address owner;
    event Received(address indexed _from, uint256 _value);

    constructor(address _owner) {
        owner = _owner;
    }

    modifier ownerOnly() {
        require(
            msg.sender == owner,
            "You do not have permission to do this action!"
        );
        _;
    }
}
