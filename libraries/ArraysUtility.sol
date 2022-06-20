// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

library ArraysUtility {

    // MAX_ARRAY_INDEX is a uint32 number which is equal to ((2 ^ 32) - 1)
    uint32 constant MAX_ARRAY_INDEX = 4294967295;

    function findIndexByValue(uint[] memory _array, uint32 _id) internal pure returns(uint32) {
        uint32 index = MAX_ARRAY_INDEX;
        require (_array.length > 0 , "Array is empty!");
        while (_array[index] != _id) {
            index++;
        }
        return index;
    }

    function findIndexByValue(address[] memory _array, address _address) internal pure returns(uint32) {
        uint32 index = MAX_ARRAY_INDEX;
        require (_array.length > 0 , "Array is empty!");
        while (_array[index] != _address) {
            index++;
        }
        return index;
    }

	function findValueByIndex(uint32[] memory _array, uint32 _index) internal pure returns(uint32) {
        require (_array.length > 0 , "Array is empty!");       
        return _array[_index];
    }

	function deleteItemByIndex(uint[]  storage _array, uint32 _index) internal {
		require (_index < _array.length , "Array index out of bound!");
        if(_index != MAX_ARRAY_INDEX) {
            for(uint32 i = _index; i < _array.length -1; i++){
                _array[i] = _array[i + 1];
            }
            _array.pop();
        }
	}

	function deleteItemByIndex(address[]  storage _array, uint32 _index) internal {
		require (_index < _array.length , "Array index out of bound!");
        if(_index != MAX_ARRAY_INDEX) {
            for(uint32 i = _index; i < _array.length -1; i++){
                _array[i] = _array[i + 1];
            }
            _array.pop();
        }
	}
	
}