// SPDX-License-Identifier: MIT
pragma solidity =0.8.10;

// solhint-disable no-inline-assembly

/// @title Unstructured Storage
/// @author Pavle Batuta <pavle@batuta.xyz>
/// @notice Read and write raw data to/from contract storage.
/// @dev Warning; this may override existing state variables!
library UnstructuredStorage {
    /// @notice Read a bool value from a given position in storage
    /// @param position The position to read from
    /// @return data The value read
    function getStorageBool(bytes32 position) internal view returns (bool data) {
        assembly {
            data := sload(position)
        }
    }

    /// @notice Read an address value from a given position in storage
    /// @param position The position to read from
    /// @return data The value read
    function getStorageAddress(bytes32 position) internal view returns (address data) {
        assembly {
            data := sload(position)
        }
    }

    /// @notice Read a bytes32 value from a given position in storage
    /// @param position The position to read from
    /// @return data The value read
    function getStorageBytes32(bytes32 position) internal view returns (bytes32 data) {
        assembly {
            data := sload(position)
        }
    }

    /// @notice Read an uint256 value from a given position in storage
    /// @param position The position to read from
    /// @return data The value read
    function getStorageUint256(bytes32 position) internal view returns (uint256 data) {
        assembly {
            data := sload(position)
        }
    }

    /// @notice Write a bool value to a given position in storage
    /// @dev Warning: may overrite existing state vaiables!
    /// @param position The position to write to
    /// @param data The data to write
    function setStorageBool(bytes32 position, bool data) internal {
        assembly {
            sstore(position, data)
        }
    }

    /// @notice Write an address value to a given position in storage
    /// @dev Warning: may overrite existing state vaiables!
    /// @param position The position to write to
    /// @param data The data to write
    function setStorageAddress(bytes32 position, address data) internal {
        assembly {
            sstore(position, data)
        }
    }

    /// @notice Write a bytes32 value to a given position in storage
    /// @dev Warning: may overrite existing state vaiables!
    /// @param position The position to write to
    /// @param data The data to write
    function setStorageBytes32(bytes32 position, bytes32 data) internal {
        assembly {
            sstore(position, data)
        }
    }

    /// @notice Write a uin value to a given position in storage
    /// @dev Warning: may overrite existing state vaiables!
    /// @param position The position to write to
    /// @param data The data to write
    function setStorageUint256(bytes32 position, uint256 data) internal {
        assembly {
            sstore(position, data)
        }
    }
}
