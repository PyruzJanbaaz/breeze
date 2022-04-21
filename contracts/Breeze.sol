// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Breeze {

    address owner;

    constructor(address _owner) {
        owner = _owner;
    }

    modifier ownerOnly(){
		require (msg.sender == owner , "You do not have permission for this action!");
		_;
	}

}