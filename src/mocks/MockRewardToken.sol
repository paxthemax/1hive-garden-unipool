// SPDX-License-Identifier: MIT
pragma solidity =0.8.10;

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";

// solhint-disable no-empty-blocks
contract MockRewardToken is ERC20PresetMinterPauser("Mock Reward Token", "MOCK") {

}
