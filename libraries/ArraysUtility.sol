// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

library ArraysUtility{

    function findIndexByValue(uint[] memory _array, uint _id) internal pure returns(uint) {
        uint index = 0;
        require (_array.length > 0 , "Array is empty!");
        while (_array[index] != _id) {
            index++;
        }
        return index;
    }

    function findIndexByValue(address[] memory _array, address _address) internal pure returns(uint) {
        uint index = 0;
        require (_array.length > 0 , "Array is empty!");
        while (_array[index] != _address) {
            index++;
        }
        return index;
    }

	function findValueByIndex(uint[] memory _array, uint _index) internal pure returns(uint) {
        require (_array.length > 0 , "Array is empty!");       
        return _array[_index];
    }

	function deleteItemByIndex(uint[]  storage _array, uint _index) internal {
		require (_index < _array.length , "Array index out of bound!");
		for(uint i = _index; i < _array.length -1; i++){
			_array[i] = _array[i + 1];
		}
		_array.pop();
	}

	function deleteItemByIndex(address[]  storage _array, uint _index) internal {
		require (_index < _array.length , "Array index out of bound!");
		for(uint i = _index; i < _array.length -1; i++){
			_array[i] = _array[i + 1];
		}
		_array.pop();
	}
	
}