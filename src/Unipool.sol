// SPDX-License-Identifier: MIT
pragma solidity =0.8.10;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./LPTokenWrapper.sol";
import "./TokenManagerHook.sol";

contract Unipool is LPTokenWrapper, TokenManagerHook {
    using SafeERC20 for IERC20;

    uint256 public constant DURATION = 30 days;

    /// @dev Emit when a user has staked tokens
    event Staked(address indexed user, uint256 amount);

    /// @dev Emit when a user has withdrawn tokens
    event Withdrawn(address indexed user, uint256 amount);

    /// @dev The reward token used in the Unipool
    IERC20 public rewardToken;

    /// @dev Construct a Unipool witth the given reward token
    constructor(IERC20 _rewardToken) {
        require(address(_rewardToken) != address(0), "Unipool::constructor: NOT_ADDRESS_ZERO");
        rewardToken = _rewardToken;
    }

    /// @dev Stake a given amount of tokens to the a user
    /// @param amount The amount of tokens to stake
    /// @param user The user to stake the tokens to
    function stake(uint256 amount, address user) public override {
        require(amount > 0, "Unipool::stake: NOT_AMOUNT_ZERO");
        super.stake(amount, user);

        emit Staked(user, amount);
    }

    function withdraw(uint256 amount, address user) public override {
        require(amount > 0, "Unipool::withdraw: NOT_AMOUNT_ZERO");
        super.withdraw(amount, user);

        emit Withdrawn(user, amount);
    }
}
