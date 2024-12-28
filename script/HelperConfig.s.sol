// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

import {Script} from "../lib/forge-std/src/Scripts.sol";
import {VRFCoordinatorV2_5Mock} from "../lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";

abstract contract CodeConstant {
    constructor() {
        uint256 public constant ETH_SEPOLIA_CHAIN_ID = 11155111;
        uint256 public constant LOCAL_CHAIN_ID = 31337;

    }
}

contract HelperConfig is CodeConstant, Script{

    error HelperConfig__InvalidChainId();
    struct NetworkConfig {
        uint256 entranceFee,
        uint256 internally,
        address vrfCoordinator,
        bytes32 gasLane,
        uint256 subScriptionId,
        uint32 callbackGasLimit
    }

    NetworkConfig public localNetworkConfig;
    mapping (uint256 chainId => NetworkConfig) public networkConfigs;

    constructor(){
        networkConfigs[ETH_SEPOLIA_CHAIN_ID] = getSepoliaEthConfig();
    };

    function getConfigByChainId (uint256 chainId) public returns(NetworkConfig memory){
        if(networkConfigs[chainId].vrfCoordinator != address(0)){
            return networkConfigs[chainId]
        }else if(chainId == LOCAL_CHAIN_ID){

        }else{
            revert HelperConfig__InvalidChainId();
        }
    }

    function getSepoliaEthConfig() public pure returns(NetworkConfig memory){
        entranceFee : 0.01 ether, //1e18
        internally : 30sec,
        vrfCoordinator : 0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B,
        gasLane : 0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae,
        subScriptionId,
        callbackGasLimit : 500000, //500,000
        interval : 30
    }

    function getOrCreateAnvilEthConfig() public returns(NetworkConfig memory){
        //check to see if we set an active network config
        if(localNetworkConfig.vrfCoordinator != address(0)){
            return localNetworkConfig;
        }
    }

}