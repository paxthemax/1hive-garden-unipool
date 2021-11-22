// SPDX-License-Identifier: MIT
pragma solidity =0.8.10;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/// @title LPTokenWrapper
/// @author Pavle Batuta <pavle@batuta,xyz>
/// @notice Defines stake/withdraw/balanceOf functions for an LP Token
contract LPTokenWrapper {
    using SafeERC20 for IERC20;

    uint256 private _totalSupply;
    mapping(address => uint256) internal _balances;

    /// @notice Get the total supply of the staked tokens
    /// @return The total supply
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /// @notice Get the token balance of an account
    /// @param account The address of the account to check
    /// @return The token balance
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /// @notice Stake a given amount of tokens to the given account
    /// @param amount The amount to stake
    /// @param account The account to stake to
    function stake(uint256 amount, address account) public virtual {
        _totalSupply += amount;
        _balances[account] = _balances[account] + amount;
    }

    /// @notice Withdraw a given amount of tokens from the given account
    /// @param amount The amount to withdraw
    /// @param account The account to withdraw from
    function withdraw(uint256 amount, address account) public virtual {
        _totalSupply -= amount;
        _balances[account] -= amount;
    }
}
