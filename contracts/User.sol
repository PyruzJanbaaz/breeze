// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './Breeze.sol';
import '../libraries/ArraysUtility.sol';

contract Users is Breeze {

    using ArraysUtility for *;

	enum UserStatus { 
		Active, 
		Inactive, 
		Locked, 
		Pending 
	}
	struct User {
		string 		firstName;
		string 		lastName;
		string 		avatar;
		UserStatus 	status;
	}
	mapping (address => User) users;
	address[] userAddresses;

    constructor() Breeze(msg.sender){
    }

	function register(string  memory _firstName, string memory _lastName, string memory _avatar) public{
		require (users[msg.sender].status >= UserStatus(0) , "User already is exist!");
		User storage user = users[msg.sender];
		user.firstName = _firstName;
		user.lastName = _lastName;
		user.avatar = _avatar;
		user.status = UserStatus.Pending;
		userAddresses.push(msg.sender);
	}

	function getUserAddresses() public view returns(address[] memory addresses){
		return userAddresses;
	}

	function getUserCount() public view returns(uint count){
		return userAddresses.length;
	}

	function getUser(address _userAddress) public view returns(User memory user){
		return users[_userAddress];
	}

	function deleteUser(address _userAddress) public ownerOnly{
		delete users[_userAddress];
		deleteUserAddressByShifting(_userAddress);
	}

	function deleteUserAddressByShifting(address _userAddress) internal ownerOnly{
		uint _index = userAddresses.findIndexByValue(_userAddress);
        userAddresses.deleteItemByIndex(_index);
	}

	function changeUserStatus(address _userAddress, UserStatus _status) public ownerOnly{
		users[_userAddress].status = _status;
	}

	function activeUserStatus(address _userAddress) public ownerOnly{
		users[_userAddress].status = UserStatus.Active;
	}

}