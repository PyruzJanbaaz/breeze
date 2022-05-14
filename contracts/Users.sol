// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "./Breeze.sol";
import "../libraries/ArraysUtility.sol";
import {DataTypes} from "../libraries/DataTypes.sol";

contract Users is Breeze {
    using ArraysUtility for *;
    using DataTypes for *;

    mapping(address => DataTypes.User) users;
    address[] userAddresses;

    constructor() Breeze(msg.sender) {}

    function register(
        string memory _firstName,
        string memory _lastName,
        string memory _avatar
    ) public {
        require(
            users[msg.sender].status >= DataTypes.UserStatus(0),
            "User already is exist!"
        );
        DataTypes.User storage user = users[msg.sender];
        user.firstName = _firstName;
        user.lastName = _lastName;
        user.avatar = _avatar;
        user.status = DataTypes.UserStatus.Pending;
        userAddresses.push(msg.sender);
    }

    function getUserAddresses()
        public
        view
        returns (address[] memory addresses)
    {
        return userAddresses;
    }

    function getUserCount() public view returns (uint256 count) {
        return userAddresses.length;
    }

    function getUser(address _userAddress)
        public
        view
        returns (DataTypes.User memory user)
    {
        return users[_userAddress];
    }

    function deleteUser(address _userAddress) public ownerOnly {
        delete users[_userAddress];
        deleteUserAddressByShifting(_userAddress);
    }

    function deleteUserAddressByShifting(address _userAddress)
        internal
        ownerOnly
    {
        uint256 _index = userAddresses.findIndexByValue(_userAddress);
        userAddresses.deleteItemByIndex(_index);
    }

    function changeUserStatus(address _userAddress, DataTypes.UserStatus _status)
        public
        ownerOnly
    {
        users[_userAddress].status = _status;
    }

    function activeUserStatus(address _userAddress) public ownerOnly {
        users[_userAddress].status = DataTypes.UserStatus.Active;
    }
}
