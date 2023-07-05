// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Whitelist.sol";

contract NFTee is ERC721Enumerable ,Ownable{

    // price PEr NFt
    uint256 constant public price = 0.01 ether;

    // max number of nft that can ever exits 
    uint256 constant public maxTOKENids = 20;

    // instances of whitelist contract
    Whitelist whitelist;

    // num of Nfts reserved for the whitelist members
    uint256 public reservedTokens;
    uint256 public numreservedTokenClaimed = 0;
    
    constructor(address _whitelistContract) ERC721("Winners Collection" , "WCT") 
    {
        whitelist = Whitelist(_whitelistContract);
        reservedTokens = whitelist.maxWhitelistedAddresses();
    }

    function Mint() public payable {

        // make sure we leave enough room for whitelist reservation
        require(totalSupply() + reservedTokens - numreservedTokenClaimed < maxTOKENids, "EXCEeDED_Max_SUPPLY");

        // If user is part of the whitelist, make sure there is still reserved tokens left
        if(whitelist.WhitelistedAddresses(msg.sender) && msg.value < price){
            
            // make sure user doesnt already own an NFT
            require(balanceOf(msg.sender) == 0,"ALready_OWN");
            numreservedTokenClaimed = numreservedTokenClaimed + 1; // ii use this because this is a gas optimization technique
        }else {
            require(msg.value >= price , "NOT_ENOUGH_ETHER");
        }
        uint256 tokenID = totalSupply();
        _safeMint(msg.sender, tokenID);
    }

    function withDraw() public onlyOwner{

        address _owner  = owner();
        uint256 amount  = address(this).balance;
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent,"TRANSACTION_FAILED!");
    }

}