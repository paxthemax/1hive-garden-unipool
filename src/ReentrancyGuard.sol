// SPDX-License-Identifier: MIT
pragma solidity =0.8.10;

import "./lib/UnstructuredStorage.sol";

/// @title ReentrancyGuard
/// @author Pavle Batuta <pavle@batuta.xyz>
/// @notice Aadd a nonReentrant mutex to prevent reentrancy on function calls
contract ReentracyGuard {
    using UnstructuredStorage for bytes32;

    /// @notice Precomputed hash of 'aragonOS.reentrancyGuard.mutex'
    bytes32 private constant REENTRANCY_MUTEX_POSITION =
        0xe855346402235fdd185c890e68d2c4ecad599b88587635ee285bce2fda58dacb;

    uint256 private constant MUTEX_UNLOCKED = 1;
    uint256 private constant MUTEX_LOCKED = 2;

    /// @dev We se the mutex value to non-zero to allow for gas refunds
    constructor() {
        REENTRANCY_MUTEX_POSITION.setStorageUint256(MUTEX_UNLOCKED);
    }

    modifier nonReentrant() {
        // Ensure mutex is unlocked
        require(
            REENTRANCY_MUTEX_POSITION.getStorageUint256() == MUTEX_UNLOCKED,
            "ReentrancyGuard::nonReentrant: REENTRANT_CALL"
        );

        // Lock the mutex
        REENTRANCY_MUTEX_POSITION.setStorageUint256(MUTEX_LOCKED);

        // Function body
        _;

        // Unlock mutex
        REENTRANCY_MUTEX_POSITION.setStorageUint256(MUTEX_UNLOCKED);
    }
}
