// SPDX-License-Identifier: MIT
pragma solidity =0.8.10;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Unipool.sol";

contract UnipoolFactory {
    /// @dev Emit when a new Unipool has been deployed
    /// @param unipool deployed Unipool
    event NewUnipool(Unipool unipool);

    /// @dev Create a new Unipool with the given rewardToken
    /// @param rewardToken address of the reward token contract
    /// @return res the Unipool contract
    function newUnipool(IERC20 rewardToken) public returns (Unipool res) {
        res = new Unipool(rewardToken);
        emit NewUnipool(res);
        return res;
    }
}
