// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

import {Script} from "../lib/forge-std/src/Scripts.sol";


contract HelperConfig is Script{
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

}