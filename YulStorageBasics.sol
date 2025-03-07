// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Storage {
    uint256 x = 10;
    uint256 y = 20;
    uint128 a = 30;
    uint256 b = 40;

    function getSlot() external pure returns (uint256 slot) {
        assembly {
            slot := x.slot
        }
    }
}
