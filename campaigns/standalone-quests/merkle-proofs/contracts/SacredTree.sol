// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SacredTree {

    bytes32 public root; // PART 1: STORE ROOT HERE

    constructor() {
        // Merkle Tree는 다음과 같은 규칙으로 생성되었습니다:
        // 1. 신뢰받는 주소들을 keccak256 해시 함수로 해싱하여 리프 노드를 만듭니다.
        // 2. 리프들을 정렬한 뒤, 쌍으로 묶어 정렬 후 해싱하는 과정을 반복합니다.
        //
        // 오프체인에서 위 과정을 거쳐 계산된 Merkle Root를 아래에 하드코딩합니다.
        // (테스트에서는 keccak256(abi.encode(root))가 
        // 0xbd150162dead740efc1f898cae744c69ccf898415b98d8c95e9ae7116361796c와 같은지 확인합니다.)
        root = 0xYourComputedMerkleRootHere; // ← 이 값을 오프체인에서 계산한 Merkle Root로 대체하세요.
    }
    
    /// Verify that an address is trusted by the tree.
    /// @param trustee Address to verify
    /// @param proof Merkle proof for verification
    function verify(
        address trustee, 
        bytes32[] calldata proof) 
    external view returns (bool) {
        // PART 2: CODE HERE
    }

}
