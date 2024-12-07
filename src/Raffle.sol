// Layout of the contract file:
// version
// imports
// errors
// interfaces, libraries, contract

// Inside Contract:
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private

// view & pure functions


// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

/**
 * @author Dheeraj joshi
 * @title Lottery Ticket
 * @dev this contract creating the sample raffle
 */

contract Raffle {
    error Raffle__SendMoreEtherRaffle();
    uint256 private immutable i_entranceFee;
    // @dev the duration of the lottery in seconds
    uint256 private immutable i_internal;
    uint256 payable[] private s_players;

    // Events
    event RaffleEntered(address indexed player);


    constructor (uint256 entranceFee , uint256 internal) {
        i_entranceFee = entranceFee;
        i_internal  = internal;
    }
    function enterRaffle() external payable {

        if(msg.value < i_entranceFee){
            revert Raffle__SendMoreEtherRaffle();
            // require(msg.value >= i_entranceFee , SendMoreEtherRaffle());
        }

        s_players.push(payable(msg.sender));
        emit enterRaffle(msg.sender);
        
    }

    function PickWinner () external {

    }

    function getEntranceFee () external view returns (uint256){
        return i_entranceFee;
    } 
}