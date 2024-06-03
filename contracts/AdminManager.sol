// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract AdminManager {
    address public superAdmin;
    address[] public AdminListAddress = [0x416BED5C07D4C3512019f425a51dd2C8a19faBfd];

    constructor() {
        superAdmin = msg.sender; 
        AdminListAddress.push(msg.sender);
// Set the deployer of the contract as the admin
    }

    modifier onlySuperAdmin() {
        require(msg.sender == superAdmin, "Only admin can perform this operation");
        _;
    }

       modifier onlySubAdmin() {
        require(addressExists(msg.sender), "Only Company Amdim  can perform this operation");
        _;
    }


    


    // Function to add an address to the registry (only admin)
    function addAddress(address _newAddress) public onlySubAdmin {
        require(!addressExists(_newAddress), "Address already exists");
        AdminListAddress.push(_newAddress);
    }

    // Function to check if an address already exists in the registry
    function addressExists(address _address) public  view returns (bool) {
        for (uint i = 0; i < AdminListAddress.length; i++) {
            if (AdminListAddress[i] == _address) {
                return true;
            }
        }
        return false;
    }

    // Function to remove an address from the registry (only admin)
    function removeAddress(address _address) public onlySubAdmin {
        require(addressExists(_address), "Address does not exist");
        
        for (uint i = 0; i < AdminListAddress.length; i++) {
            if (AdminListAddress[i] == _address) {
                delete AdminListAddress[i];
                // Move the last element into the position of the deleted element
                AdminListAddress[i] = AdminListAddress[AdminListAddress.length - 1];
                // Remove the last element
                AdminListAddress.pop();
                break;
            }
        }
    }

    // Function to show all admin addresses
    function showAllAdmins() public view returns (address[] memory) {
        return AdminListAddress;
    }
}