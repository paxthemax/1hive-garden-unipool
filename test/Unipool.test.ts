import {expect} from './utils/chai-setup';
import './fixtures/Unipool';
import fixture from './fixtures/Unipool';

describe('Unipool', function () {
  it('should deploy Unipool with the correct reward token', async function () {
    const {Unipool, MockRewardToken} = await fixture();
    expect(await Unipool.rewardToken()).to.be.eq(MockRewardToken.address);
  });
});
