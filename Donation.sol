// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./DonationHelper.sol";

contract Donation {

    // Using the Donation Helper Library
    using DonationHelper for uint256;

    // Holds the address of the contract owner or deployer
    address public owner;
    
    // An array of donators
    address[] public donators;

    // A mapping of donators and the amount they donated
    mapping(address => uint256) public donatorToAmount;

    // Minimum donation in USD
    uint256 public minimumUSD = 100 * 1e18;

    constructor(){
        owner = msg.sender;
    }

    function donate() public payable {
        require(msg.value.getConversionRate() >= minimumUSD, "A minimum of $100 worth of Eth is required to donate");
        //Record donators and amount contributed
        donators.push(msg.sender);
        donatorToAmount[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        (bool sent, ) = (msg.sender).call{value: address(this).balance}("");
        require(sent, "Could not send funds to contract owner");
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner of the contract can withdraw funds");
        _;
    }
    
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

}
