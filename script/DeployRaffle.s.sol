// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

// import {Script} from "../lib/forge-std/src/Scripts.sol";
import {Script} from "../lib/forge-std/src/Script.sol";
import {Raffle} from "../src/Raffle.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {CreateSubscription} from "../script/Interactions.s.sol";

contract DeployRaffle is Script {
    function run() public {}

    function deployRaffleContract() public returns (Raffle, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();

        //local -> deploy mocks get local config;
        //sepolia -> get sepolia config
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();

        if(config.subscriptionId == 0){
            CreateSubscription createSubscription =  new  CreateSubscription();
            (config.subScriptionId , config.vrfCoordinator)=createSubscription.createSubscription(config.vrfCoordinator);
        }

        vm.startBroadcast();

        Raffle raffle = new Raffle(
            config.entranceFee,
            config.internally,
            config.vrfCoordinator,
            config.gasLane,
            config.subScriptionId,
            config.callbackGasLimit
        );
        vm.stopBroadcast();
        return (raffle, helperConfig);
    }
}
