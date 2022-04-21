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

	function findIdByIndex(uint[] memory _array, uint _index) internal view returns(uint) {
        return _array[_index];
    }

	function deleteItemByIndex(uint[]  storage _array, uint _index) internal {
		require (_index < _array.length , "Array index out of bound!");
		for(uint i = _index; i < _array.length -1; i++){
			_array[i] = _array[i + 1];
		}
		_array.pop();
	}

	
}