// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint256 public count;
    address public owner;
    
    event CountChanged(uint256 newCount, address changedBy);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    constructor() {
        count = 0;
        owner = msg.sender;
    }
    
    function increment() public {
        count += 1;
        emit CountChanged(count, msg.sender);
    }
    
    function decrement() public {
        require(count > 0, "Counter cannot be negative");
        count -= 1;
        emit CountChanged(count, msg.sender);
    }
    
    function reset() public onlyOwner {
        count = 0;
        emit CountChanged(count, msg.sender);
    }
    
    function getCount() public view returns (uint256) {
        return count;
    }
}