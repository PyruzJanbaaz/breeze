// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

library ArraysUtility{

    function findIndexById(uint[] memory _array, uint _id) internal view returns(uint) {
        uint index = 0;
        while (_array[index] != _id) {
            index++;
        }
        return index;
    }
}