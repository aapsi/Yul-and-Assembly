// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Storage {
    uint256 x = 10;
    uint256 y = 20;
    uint128 a = 1;
    uint128 b = 1;

    function getSlot() external pure returns (uint256 slot) {
        assembly {
            slot := x.slot
        }
        return slot;
    }

    function getVar(uint256 slot) external view returns (uint256 res) {
        assembly {
            res := sload(slot)
        }

        return res;
    }

    function setVar(uint256 slot, uint256 newval) external {
        assembly {
            sstore(slot, newval)
        }
    }

    function getVarYul(uint256 slot) external view returns (bytes32 res) {
        assembly {
            res := sload(slot)
        }
        return res;
    }
}
