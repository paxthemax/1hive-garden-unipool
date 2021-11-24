import {ethers, deployments, getNamedAccounts, getUnnamedAccounts} from 'hardhat';
import {setupUser, setupUsers} from '../utils';

const fixture = deployments.createFixture(async function () {
  await deployments.fixture();
  const {deployer} = await getNamedAccounts();
  const {deploy} = deployments;

  const {address: mockLPTokenAddress} = await deploy('MockLPToken', {
    from: deployer,
    autoMine: true,
  });

  const contracts = {
    MockLPToken: await ethers.getContractAt('MockLPToken', mockLPTokenAddress),
  };
  const users = await setupUsers(await getUnnamedAccounts(), contracts);

  return {
    ...contracts,
    deployer: setupUser(deployer, contracts),
    users,
  };
});

export default fixture;
