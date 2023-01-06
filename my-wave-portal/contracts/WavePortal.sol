// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;
import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    constructor() {
        console.log("Smart contract started");
        console.log("");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
        getTotalWaves();
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        console.log("");
        return totalWaves;
    }
}