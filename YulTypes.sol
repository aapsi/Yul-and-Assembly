// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract YulTypes {
    function getNumber() external pure returns (uint256) {
        uint256 x;

        assembly {
            x := 1
        }
        return x;
    }

    function getHex() external pure returns (uint256) {
        uint256 x;

        assembly {
            x:= 0xa
        }

        return x;
    }

    function demoString() external pure returns (string memory) {
        bytes32 myString = "";

        assembly {
            myString := "aapsi khaira"
        }

        return(string(abi.encodePacked(myString)));
    }

    function getBool() external pure returns (bool) {
        bool x;

        assembly {
            x:=1
        }

        return x;
    }
}