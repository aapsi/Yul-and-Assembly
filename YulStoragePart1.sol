// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract StoragePart1 {
    uint128 public C = 4;
    uint96 public D = 6;
    uint16 public E = 8;
    uint8 public F = 1;

    function readBySlot(uint256 slot) external view returns (bytes32 value) {
        assembly {
            value := sload(slot)
        }
    }

    function getOffsetE() external view returns (uint256 offset) {
        assembly {
            let slot := E.slot
            offset := sload(slot)
        }
    }

    function readE() external view returns (uint16 e) {
        assembly {
            let value := sload(E.slot)
            // 0x0001000800000000000000000000000600000000000000000000000000000004

            // E.offset = 28

            let shifted := shr(mul(E.offset, 8), value)
            // mul(E.offset, 8) => 0x100000000000000000000000000000000000000000000000000000000

            e := and(0xffffffff, shifted)
            // here the number of f's is incorrect but the code will workk fine because out return value is uint16 so we already are taking the last 4 bytes of the result which is our E
        }
    }

    function readE2() external view returns (uint16 e) {
        assembly {
            let value := sload(E.slot)
            // 0x0001000800000000000000000000000600000000000000000000000000000004

            // E.offset = 28

            let shifted := shr(mul(E.offset, 8), value)
            // mul(E.offset, 8) => 0x100000000000000000000000000000000000000000000000000000000

            e := and(0xffff, shifted)
            // here we are masking the 4 bytes where we have our 0008
        }
    }

    function readEAlt() external view returns (uint256 e) {
        assembly {
            let slot := sload(E.slot)
            let offset := sload(E.offset)
            let value := sload(E.slot) // must load in 32 byte increment

            // shift right by 224 = divide by (2 ** 224). below is 2 ** 224 in hex
            let shifted := div(
                value,
                0x100000000000000000000000000000000000000000000000000000000
            )

            e := and(0xffff, shifted)
        }
    }

    // masks can be hardcoded because variable storage slot and offsets are fixed
    // V and 00 = 00
    // V and FF = V
    // V or  00 = V
    // function arguments are always 32 bytes long under the hood
    function writeToE(uint16 newE) external {
        assembly {
            // newE = 0x000000000000000000000000000000000000000000000000000000000000000a

            let c := sload(E.slot) // slot 0
            // c = 0x0001000800000000000000000000000600000000000000000000000000000004

            let clearedE := and(
                c,
                0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff
            )
            // mask     = 0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff
            // c        = 0x0001000800000000000000000000000600000000000000000000000000000004
            // clearedE = 0x0001000000000000000000000000000600000000000000000000000000000004

            let shiftedNewE := shl(mul(E.offset, 8), newE)
            // shiftedNewE = 0x0000000a00000000000000000000000000000000000000000000000000000000
            let newVal := or(shiftedNewE, clearedE)
            // shiftedNewE = 0x0000000a00000000000000000000000000000000000000000000000000000000
            // clearedE    = 0x0001000000000000000000000000000600000000000000000000000000000004
            // newVal      = 0x0001000a00000000000000000000000600000000000000000000000000000004
            sstore(C.slot, newVal)
        }
    }

    // NEVER DO THIS IN PRODUCTION
    function writeBySlot(uint256 slot, uint256 value) external {
        assembly {
            sstore(slot, value)
        }
    }
}
