import {deployments, ethers, getNamedAccounts, getUnnamedAccounts} from 'hardhat';
import {MockRewardToken} from '../../typechain/MockRewardToken';
import {Unipool} from '../../typechain/Unipool';
import {setupUser, setupUsers} from '../utils';

const fixture = deployments.createFixture(async function () {
  await deployments.fixture();
  const {deployer} = await getNamedAccounts();

  const {address: rewardTokenAddress} = await deployments.deploy('MockRewardToken', {
    from: deployer,
    autoMine: true,
  });

  const {address: unipoolAddress} = await deployments.deploy('Unipool', {
    from: deployer,
    args: [rewardTokenAddress],
    autoMine: true,
  });

  const contracts = {
    MockRewardToken: (await ethers.getContractAt('MockRewardToken', rewardTokenAddress)) as MockRewardToken,
    Unipool: (await ethers.getContractAt('Unipool', unipoolAddress)) as Unipool,
  };

  const users = await setupUsers(await getUnnamedAccounts(), contracts);
  return {
    ...contracts,
    deployer: await setupUser(deployer, contracts),
    users,
  };
});

export default fixture;
