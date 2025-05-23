// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Showcase contract inheritance

contract Ownable {

    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "must be owner");
        _;
    }
}

contract SecretVault {
    string secret;

    constructor(string memory _secret) {
        secret = _secret;
    }

    function getSecret() public view returns (string memory) {
        return secret;
    }
}

//@inheritdoc extend from ownable  inheritance
contract Secret is Ownable {


    address secretVault;

    constructor(string memory _secret) {
        //talk to the other contract
        SecretVault _secretVault = new SecretVault(_secret);
        secretVault = address(_secretVault);
        super;  //invoke parents function
    }

    function getSecret() public view onlyOwner returns (string memory) {
        return SecretVault(secretVault).getSecret();
    }
}