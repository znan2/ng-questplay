// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

abstract contract Multicall {

    /**
     * @dev Executes a batch of function calls on this contract.
     * @param calls The sequence of ABI calldata of the transactions to forward to this contract.
     *
     * @return results Returns array of call results represented as bytes.
     */
    function multicall(
        bytes[] calldata calls
    ) external virtual returns (bytes[] memory results) {
        results = new bytes[](calls.length);

        for(uint256 i; i < results.length; i++) {
            (bool success, bytes memory data) = address(this).delegatecall(calls[i]);
            require(success, "Multicall: call failed");
            results[i] = data;
        }
        return results;
    }

}
