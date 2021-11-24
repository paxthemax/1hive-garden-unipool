// SPDX-License-Identifier: MIT
pragma solidity =0.8.10;

import "./ReentrancyGuard.sol";

contract TokenManagerHook is ReentracyGuard {
    using UnstructuredStorage for bytes32;

    /// @dev Hadcoded value of keccak256("hookedTokenManager.tokenManagerHook.tokenManager")
    bytes32 private constant TOKEN_MANAGER_POSITION =
        0x5c513b2347f66d33af9d68f4a0ed7fbb73ce364889b2af7f3ee5764440da6a8a;

    /// @dev Only callable by TokenManager
    modifier onlyTokenManager() {
        require(getTokenManager() == msg.sender, "TokenManagerHook::onlyTokenManager: MUST_TOKEN_MANAGER");
        _;
    }

    /// @dev Get the address of the TokenManager
    /// @return result Returned address
    function getTokenManager() public view returns (address result) {
        return TOKEN_MANAGER_POSITION.getStorageAddress();
    }

    /// @dev Called when this contract is registeded as a TokenManager hook
    /// @param hookID Position in which the hook will be called
    /// @param token Token controlled by the TokenManager
    function onRegisterAsHook(uint256 hookID, address token) external nonReentrant {
        require(getTokenManager() == address(0), "TokenManagerHook::onRegisterAsHook: TOKEN_MANAGER_REGISTERED");

        TOKEN_MANAGER_POSITION.setStorageAddress(msg.sender);

        // This method can be overriden by the hook implementation
        _onRegisterAsHook(msg.sender, hookID, token);
    }

    /// @dev Called when this hook is being removed from the TokenManager
    /// @param hookID Position in which the hook is going to be called
    /// @param token Token controlled by the TokenManager
    function onRevokeAsHook(uint256 hookID, address token) external onlyTokenManager nonReentrant {
        _onRevokeAsHook(hookID, token);
    }

    /// @dev Notifies the hook about a token transfer, allowing the hook to react to it. Should return true
    /// by default, to allow functions in the TokenManager execute sucessfully
    /// @param from The transfer origin
    /// @param to The transfer destination
    /// @param amount The amount of tokens to transfer
    function onTransfer(
        address from,
        address to,
        uint256 amount
    ) external onlyTokenManager nonReentrant returns (bool) {
        return _onTransfer(from, to, amount);
    }

    /// @dev Notifies the hook about an approval, allowing the hook to react to it. hould return true
    /// by default, to allow functions in the TokenManager execute sucessfully
    /// @param holder The holder allowing to spend
    /// @param spender The spender that is allowed to spend
    /// @param amount The amount of tokens allowed to spend
    function onApprove(
        address holder,
        address spender,
        uint256 amount
    ) external onlyTokenManager nonReentrant returns (bool) {
        return _onApprove(holder, spender, amount);
    }

    /// @dev Override if necessary
    function _onRegisterAsHook(
        address,
        uint256,
        address
    ) internal virtual {
        return;
    }

    /// @dev Override if necessary
    function _onRevokeAsHook(uint256, address) internal virtual {
        return;
    }

    /// @dev Override if necessary
    function _onTransfer(
        address,
        address,
        uint256
    ) internal virtual returns (bool) {
        return true;
    }

    /// @dev Override if necessary
    function _onApprove(
        address,
        address,
        uint256
    ) internal virtual returns (bool) {
        return true;
    }
}
