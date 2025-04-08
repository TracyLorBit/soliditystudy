// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    uint256 public storedData;
    
    constructor(uint256 _initialValue) {
        storedData = _initialValue;
    }
    
    function set(uint256 _value) public {
        storedData = _value;
    }
    
    function get() public view returns (uint256) {
        return storedData;
    }
    
    function increment() public {
        storedData += 1;
    }
    
    function decrement() public {
        require(storedData > 0, "Value cannot be negative");
        storedData -= 1;
    }
}