// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;
import "hardhat/console.sol";

contract WavePortal {
    constructor() payable {
        console.log("Smart Contract Started !!!");
        console.log("");
    }

    uint256 totalWaves;
    uint256 prizeAmount = 0.0001 ether;

    event NewWave(address indexed from, uint256 timestamp, string message);
    
    struct Wave { 
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    } // Wave struct
    
    Wave[] waves; // array of Wave structs holding all the waves I receive

    function waveMessage(string memory _message) public {
        totalWaves += 1;
        console.log("%s has waved with message: %s", msg.sender, _message);
        waves.push(Wave(msg.sender, _message, block.timestamp)); // store the wave in the array
        emit NewWave(msg.sender, block.timestamp, _message);
        getTotalWaves();

        require(prizeAmount <= address(this).balance, "Cannot withdraw more money than the contract contains.");
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    } // wave from ewallet with message

    function wave() public {
        string memory _message = "No message sent.";
        totalWaves += 1;
        console.log("%s has waved with message: %s", msg.sender, _message);
        waves.push(Wave(msg.sender, _message, block.timestamp)); // store the wave in the array
        emit NewWave(msg.sender, block.timestamp, _message);
        getTotalWaves();

        require(prizeAmount <= address(this).balance, "Cannot withdraw more money than the contract contains.");
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    } // wave from ewallet without message

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        console.log("");
        return totalWaves;
    }
}