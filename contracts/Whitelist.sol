// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Whitelist {

    // max number of addresses allowed
    uint8 public maxWhitelistedAddresses;

    // if an address is whitelisted it will show true otherwise false
    mapping(address => bool) public WhitelistedAddresses;

    // keep the track of how many addresses have been whitelisted 
    uint8 public numAddressesWhitelisted;

    // Setting the Max number of whitelisted addresses
    // User will put the value at the time of deployment    
    constructor(uint8 _maxWhitelistedAddr) {
        maxWhitelistedAddresses = _maxWhitelistedAddr;
    }

    function AddaddressToWhitelist() public {

        // check if the user has already been whitelisted
        require(!WhitelistedAddresses[msg.sender],"User has already been whitelisted!");

        // check if the numAddressesWhitelisted < maxWhitelistedAddresses, if not then throw an erro
        require(numAddressesWhitelisted < maxWhitelistedAddresses,"More addresses cant be Addresess , Limit Reached");

        //add the address whick x=calle dthe function to the whitelistedaddr array
        WhitelistedAddresses[msg.sender] = true;
        numAddressesWhitelisted += 1;
        
    }

}