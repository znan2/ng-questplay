// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract For {
    
    /// @notice Sum the elements in [`beg`, `end`) and return the result.
    /// Skips elements divisible by 5. 
    /// Exits the summation loop when it encounters a factor of `end`.
    /// @dev You can ignore overflow / underflow bugs.
    function sumElements(uint256 beg, uint256 end)
        public
        pure
        returns (uint256 sum)
    {
        assembly {
            sum := 0
            let i := beg
            for { } lt(i, end) { i := add(i, 1) } {
                if eq(mod(end, i), 0) {
                    break
                }
                if eq(mod(i, 5), 0) {
                    continue
                }
                sum := add(sum, i)
            }
        }
    }
}
