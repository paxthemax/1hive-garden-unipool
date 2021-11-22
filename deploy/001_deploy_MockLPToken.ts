import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  if (hre.network.live) {
    return;
  }

  const {deployer} = await hre.getNamedAccounts();
  const {deploy} = hre.deployments;

  await deploy('MockLPToken', {
    from: deployer,
    log: true,
    autoMine: true, // speed up deployment on local network (ganache, hardhat), no effect on live networks
  });
};

export default func;
func.id = 'deploy_mock_lp_token'; // id required to prevent reexecution
func.tags = ['MockLPToken'];
