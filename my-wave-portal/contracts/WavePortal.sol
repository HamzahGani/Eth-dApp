// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;
import "hardhat/console.sol";

contract WavePortal {
    constructor() payable {
        console.log("Smart Contract Started !!!");
        console.log("");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    uint256 totalWaves;
    uint256 prizeAmount = 0.0001 ether; // amount of eth to give to winners
    uint256 private seed; // help generate random number

    event NewWave(address indexed from, uint256 timestamp, string message);
    
    struct Wave { 
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    } // Wave struct
    
    Wave[] waves; // array of Wave structs holding all the waves I receive

    mapping(address => uint256) public lastWavedAt;

    function waveMessage(string memory _message) public {
        // user must wait 15 minutes between waves
        require(lastWavedAt[msg.sender] + 15 minutes < block.timestamp, "Wait 15mins between waves");
        lastWavedAt[msg.sender] = block.timestamp; // Update the current timestamp we have for the user

        totalWaves += 1;
        console.log("%s has waved with message: %s", msg.sender, _message);
        waves.push(Wave(msg.sender, _message, block.timestamp)); // store the wave in the array

        seed = (block.timestamp + block.difficulty + seed) % 100;
        console.log("Random # generated: %d", seed);
        if (seed <= 50) {
            console.log("%s won!", msg.sender);
            require(prizeAmount <= address(this).balance, "Cannot withdraw more money than the contract contains.");
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        } // 50% chance that the user wins the prize.
        
        emit NewWave(msg.sender, block.timestamp, _message);
        getTotalWaves();
    } // wave from ewallet with message

    function wave() public {
        // user must wait 15 minutes between waves
        require(lastWavedAt[msg.sender] + 15 minutes < block.timestamp, "Wait 15mins between waves");
        lastWavedAt[msg.sender] = block.timestamp; // Update the current timestamp we have for the user

        string memory _message = "No message sent.";
        totalWaves += 1;
        console.log("%s has waved with message: %s", msg.sender, _message);
        waves.push(Wave(msg.sender, _message, block.timestamp)); // store the wave in the array

        seed = (block.timestamp + block.difficulty + seed) % 100;
        console.log("Random # generated: %d", seed);
        if (seed <= 50) {
            console.log("%s won!", msg.sender);
            require(prizeAmount <= address(this).balance, "Cannot withdraw more money than the contract contains.");
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        } // 50% chance that the user wins the prize.

        emit NewWave(msg.sender, block.timestamp, _message);
        getTotalWaves();
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