import {expect} from './utils/chai-setup';
import {deployments, ethers, getUnnamedAccounts} from 'hardhat';
import {MockLPToken} from '../typechain';
import {setupUsers} from './utils';

const setup = deployments.createFixture(async () => {
  await deployments.fixture('MockLPToken');
  const contracts = {
    MockLPToken: (await ethers.getContract('MockLPToken')) as MockLPToken,
  };
  const users = await setupUsers(await getUnnamedAccounts(), contracts);
  return {
    ...contracts,
    users,
  };
});

describe('LPTokenWrapper', function () {
  it('should stake the right amount of tokens', async function () {
    const {users, MockLPToken} = await setup();
    await users[0].MockLPToken.stake('10000', users[1].address);
    await users[1].MockLPToken.stake('20000', users[0].address);

    expect(await MockLPToken.balanceOf(users[0].address)).to.be.eq('20000');
    expect(await MockLPToken.balanceOf(users[1].address)).to.be.eq('10000');
    expect(await MockLPToken.totalSupply()).to.be.eq('30000');
  });

  it('should withdraw the right amount of tokens', async function () {
    const {users, MockLPToken} = await setup();
    await users[0].MockLPToken.stake('10000', users[1].address);
    await users[1].MockLPToken.stake('20000', users[0].address);

    await users[0].MockLPToken.withdraw('10000', users[0].address);
    await users[1].MockLPToken.withdraw('10000', users[1].address);

    expect(await MockLPToken.balanceOf(users[0].address)).to.be.eq('10000');
    expect(await MockLPToken.balanceOf(users[1].address)).to.be.eq('0');
    expect(await MockLPToken.totalSupply()).to.be.eq('10000');
  });
});
