// SPDX-License-Identifier: MIT
pragma solidity =0.8.10;

import "../LPTokenWrapper.sol";

contract MockLPToken is LPTokenWrapper {
    function stake(uint256 amount, address account) public override {
        super.stake(amount, account);
    }

    function withdraw(uint256 amount, address account) public override {
        super.withdraw(amount, account);
    }
}
