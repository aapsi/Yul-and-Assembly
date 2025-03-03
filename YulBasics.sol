// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract PrimeNum {
    function isPrime(uint256 x) public pure returns(bool p) {
        p = true;
        assembly {
            let halfX := add(div(x,2), 1)
            let i := 2
            for { } lt(i, halfX) { }
            {
                if iszero(mod(x, i)) {
                    p := 0
                    break
                }

                i := add(i, 1)
            }
        }
    }
}

contract IfComparison {
    function isTruthy() external pure returns (uint256 result) {
        result = 2;

        assembly {
            if 2 {
                result := 1
            }
        }

        return 2;
    }


    function isFalsy() external pure returns (uint256 result) {
        result = 1;

        assembly {
            if 0 {
                result := 2
            }
        }

        return result;
        
    }

    function negation() external pure returns (uint256 result) {
        result = 1;

        assembly {
            if iszero(0) {
                result := 2
            }
        }

        return result;
    }

    function unsafeNegation1() external pure returns (uint256 result) {
        result = 1;

        assembly {
            if not(0) {
                result := 2
            }
        }

        return result;
    }

    function bitflip() external pure returns (bytes32 result) {
        assembly {
            result := not(2)
        }

        return result; 
        
    }

    function unsafeNegation2() external pure returns (uint256 result) {

        result = 1;

        assembly {
            if not(2) {
                result := 2
            }
        }
        return result;
    }

    function max(uint256 x, uint256 y) external pure returns (uint256 maximum) {
        assembly {
            if lt(x,y) {
                maximum := y
            }

            if iszero(lt(x,y)) {
                maximum := x
            }
        }
    }
}