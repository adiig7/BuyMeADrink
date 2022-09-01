// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract BuyMeADrink{

    struct Creator{
        address creatorAddress;
        string username;
        string name;
        string fieldOfWork;
        string bio;
        uint8 age;
    }

    struct Donation{
        string name;
        string message;
        uint256 amount;
    }

    mapping(uint256 => Creator) creators;
    mapping(uint256 => Donation) donations;
    mapping(address => Donation[]) donationByAddress;

    uint256 public countCreators = 0;
    uint256 public countDonations = 0;

    function getCreator(uint256 _id) public view returns(Creator memory){
        return creators[_id];
    }

    function getDonationsForACreator(address creatorAddress) public view returns(Donation[] memory){
        return donationByAddress[creatorAddress];
    }

    function getAddress(uint256 _id) public view returns(address){
        return creators[_id].creatorAddress;
    }

    function getBalance(address _creatorAddress) public view returns(uint256){
        return _creatorAddress.balance;
    }

    function addCreator(string memory _username, string memory _name, string memory _fieldOfWork, string memory _bio, uint8 _age) public {
        countCreators += 1;
        creators[countCreators] = Creator(msg.sender,_username, _name, _fieldOfWork, _bio, _age);
    }

    function donate(string memory _name, string memory _message, uint256 _creatorId, uint256 _amount) public payable{
        address payable creatorAddress = payable(getCreator(_creatorId).creatorAddress);
        (bool sent, ) = creatorAddress.call{value: _amount}("");
        require(sent, "Failed to send Ether");
        countDonations += 1;
        donations[countDonations] = Donation(_name, _message, _amount);
        donationByAddress[creatorAddress].push(Donation(_name, _message, _amount));
    }
}