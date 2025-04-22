// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleIterableMap {
    // Store value for each user
    mapping(address => uint256) public userValue;

    // Store list of all users (to allow iteration)
    address[] public users;

    // Track if a user has already added a value (to prevent duplicate entries in users array)
    mapping(address => bool) public hasAdded;
    // 🔹 Add or update a value for the caller
    function addOrUpdate(uint256 value) public {
        // Save the value for msg.senderx
        userValue[msg.sender] = value;

        // If this is the first time msg.sender is adding, push to users list
        if (!hasAdded[msg.sender]) {
            users.push(msg.sender);
            hasAdded[msg.sender] = true;
        }
    }


    // 🔹 Get the total number of users who have added data
    function getUserCount() public view returns (uint256) {
        return users.length;
    }

    // 🔹 Get a user's address by their index in the array
    function getUserAtIndex(uint index) public view returns (address) {
        require(index < users.length, "Index out of bounds");
        return users[index];
    }

    // 🔹 Get user address and their value at a specific index
    function getUserAndValue(uint index) public view returns (address, uint256) {
        require(index < users.length, "Index out of bounds");
        address user = users[index];// 0x233r324...12
        return (user, userValue[user]);
    }

    // 🔹 Get all users and their values (for frontend/display use)
    function getAll() public view returns (address[] memory, uint256[] memory) {
        uint256 len = users.length;
        address[] memory addresses = new address[](len);
        uint256[] memory values = new uint256[](len);

        for (uint256 i = 0; i < len; i++) {
            address user = users[i];//0x12324..123123
            addresses[i] = user;
            values[i] = userValue[user];
        }

        return (addresses, values);
    }

    // // 🔹 Remove the user from map and user list (optional but shows complete control)
    // function removeMyEntry() public {
    //     require(hasAdded[msg.sender], "No value set yet");

    //     // Reset value
    //     userValue[msg.sender] = 0;
    //     hasAdded[msg.sender] = false;

    //     // Remove from array by swapping with last and popping
    //     for (uint256 i = 0; i < users.length; i++) {
    //         if (users[i] == msg.sender) {
    //             users[i] = users[users.length - 1];
    //             users.pop();
    //             break;
    //         }
    //     }
    // }
}
