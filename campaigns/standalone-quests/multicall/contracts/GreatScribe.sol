// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract GreatScribe {

    /**
     * @dev Executes a batch of read-only calls on `archives`.
     * @param calls The sequence of ABI calldata of the read-only calls to forward to `archives`.
     * @param archives Address of the {GreatArchives} to read from.
     *
     * @return results Returns array of call results represented as bytes.
     */
    function multiread(
        bytes[] calldata calls,
        address archives
    ) external view returns (bytes[] memory results) {
        results = new bytes[](calls.length);

        for(uint256 i; i < results.length; i++) {
            (bool success, bytes memory data) = archives.staticcall(calls[i]);
            require(success, "GreatScribe: call failed");
            results[i] = data;
        }
        
        return results;
    }
    
    /**
     * @dev Executes a batch of read/write transactions on `archives`.
     * @param calls The sequence of ABI calldata of the transactions to forward to `archives`.
     * @param archives Address of the {GreatArchives} to write onto.
     *
     * @return results Returns array of call results represented as bytes.
     */
    function multiwrite(
        bytes[] calldata calls,
        address archives
    ) external returns (bytes[] memory results) {
        results = new bytes[](calls.length);

        for(uint256 i; i < results.length; i++) {
            (bool success, bytes memory data) = archives.call(calls[i]);
            require(success, "GreatScribe: call failed");
            results[i] = data;
        }
        return results;
    }
}
