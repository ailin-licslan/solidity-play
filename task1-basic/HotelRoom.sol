// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Showcase payment transfers, enums, visibility, modifiers & events

contract HotelRoom {
    enum Statuses {
        Vacant,
        Occupied
    }
    Statuses public currentStatus;

    //event
    event Occupy(address _occupant, uint256 _value);

    //the owner of this contract , payable means current address can receive the money  ETH
    address payable public owner;

    constructor() {
        //msg.sender the people who call this function also deploy it , only run once
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    //check status
    modifier onlyWhileVacant() {
        require(currentStatus == Statuses.Vacant, "Currently occupied.");
        _;
    }

    //check price
    modifier costs(uint256 _amount) {
        require(msg.value >= _amount, "Not enough Ether provided.");
        _;
    }

    //onlyWhileVacant & costs are the requires before execute the logic later
    function book() public payable onlyWhileVacant costs(2 ether) {

        currentStatus = Statuses.Occupied;

        //owner.transfer(msg.value) same thing here , send money(ETH) to owner, the money comes from the people who call this function
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(sent);

        emit Occupy(msg.sender, msg.value);
    }
}