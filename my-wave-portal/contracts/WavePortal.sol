// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;
import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    event NewWave(address indexed from, uint256 timestamp, string message);
    
    struct Wave { 
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    } // Wave struct
    
    Wave[] waves; // array of Wave structs holding all the waves I receive

    constructor() {
        console.log("Smart Contract Started !!!");
        console.log("");
    }

    function waveMessage(string memory _message) public {
        totalWaves += 1;
        console.log("%s has waved with message: %s", msg.sender, _message);
        waves.push(Wave(msg.sender, _message, block.timestamp)); // store the wave in the array
        emit NewWave(msg.sender, block.timestamp, _message);
        getTotalWaves();
    } // wave from ewallet with message

    function wave() public {
        totalWaves += 1;
        console.log("%s has waved!: No message sent.", msg.sender);
        waves.push(Wave(msg.sender, "No message sent.", block.timestamp)); // store the wave in the array
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