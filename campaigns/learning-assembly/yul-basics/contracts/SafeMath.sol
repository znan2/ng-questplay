// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SafeMath {

    /// @notice lhs + rhs를 반환합니다.
    /// @dev 오버플로/언더플로 발생 시 revert합니다.
    function add(
        int256 lhs, 
        int256 rhs
    ) public pure returns (int256 result) {
        assembly {
            // 1. 덧셈을 수행합니다.
            let r := add(lhs, rhs)

            // 2. 부호 비트 검사를 이용하여 오버플로/언더플로를 감지합니다:
            //    lhs와 rhs가 같은 부호를 가지지만 결과 r의 부호가 다르면 오버플로우가 발생합니다.
            //    즉, ((lhs ^ r) & (rhs ^ r))의 부호 비트가 설정되어 있으면 overflow입니다.
            let signBit := 0x8000000000000000000000000000000000000000000000000000000000000000
            let overflowCheck := and(xor(lhs, r), xor(rhs, r))
            // overflowCheck의 부호 비트가 설정되어 있으면 revert합니다.
            if iszero(eq(and(overflowCheck, signBit), 0)) {
                revert(0, 0)
            }

            result := r
        }
    }

    /// @notice lhs - rhs를 반환합니다.
    /// @dev 오버플로/언더플로 발생 시 revert합니다.
    function sub(int256 lhs, int256 rhs) public pure returns (int256 result) {
        assembly {
            // 1. 뺄셈을 수행합니다.
            let r := sub(lhs, rhs)

            // 2. 부호 비트 검사를 통해 오버플로우를 감지합니다:
            //    뺄셈의 경우, ((lhs ^ rhs) & (lhs ^ r))의 부호 비트가 설정되어 있으면 overflow입니다.
            let signBit := 0x8000000000000000000000000000000000000000000000000000000000000000
            let overflowCheck := and(xor(lhs, rhs), xor(lhs, r))
            if iszero(eq(and(overflowCheck, signBit), 0)) {
                revert(0, 0)
            }

            result := r
        }
    }

    /// @notice lhs * rhs를 반환합니다.
    /// @dev 오버플로/언더플로 발생 시 revert합니다.
    function mul(int256 lhs, int256 rhs) public pure returns (int256 result) {
        assembly {
            // 만약 피연산자 중 하나가 0이면, 결과는 0입니다.
            if or(iszero(lhs), iszero(rhs)) {
                result := 0
            } {
                let product := mul(lhs, rhs)
                // 다음 조건을 만족하는지 확인하여 오버플로우를 검사합니다:
                //   product / lhs == rhs  그리고  product / rhs == lhs.
                if or(
                    iszero(eq(sdiv(product, lhs), rhs)),
                    iszero(eq(sdiv(product, rhs), lhs))
                ) {
                    revert(0, 0)
                }
                result := product
            }
        }
    }

    /// @notice lhs / rhs를 반환합니다.
    /// @dev 오버플로/언더플로 발생 시 revert합니다.
    function div(int256 lhs, int256 rhs) public pure returns (int256 result) {
        assembly {
            // 1. 0으로 나누는지 확인합니다.
            if eq(rhs, 0) {
                revert(0, 0)
            }

            // 2. MIN_INT = -2^255를 준비합니다.
            let MIN_INT := sub(0, shl(255, 1))

            // 3. lhs가 MIN_INT이고 rhs가 -1인 경우 오버플로우가 발생합니다.
            //    어셈블리에서는 -1을 표현하기 위해 sub(0,1) 또는 not(0)을 사용합니다.
            if and(eq(lhs, MIN_INT), eq(rhs, sub(0, 1))) {
                revert(0, 0)
            }

            // 4. 부호 있는 나눗셈을 위해 sdiv를 사용합니다.
            result := sdiv(lhs, rhs)
        }
    }
}
