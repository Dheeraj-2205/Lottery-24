// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

// import {Script} from "../lib/forge-std/src/Scripts.sol";
import {Script} from "../lib/forge-std/src/Script.sol";
import {Raffle} from "../src/Raffle.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {CreateSubscription, FundSubscription, AddConsumer} from "../script/Interactions.s.sol";

contract DeployRaffle is Script {
    function run() public {}

    function deployRaffleContract() public returns (Raffle, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();

        //local -> deploy mocks get local config;
        //sepolia -> get sepolia config
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();

        if (config.subScriptionId == 0) {
            CreateSubscription createSubscription = new CreateSubscription();
            (config.subScriptionId, config.vrfCoordinator) =
                createSubscription.createSubscription(config.vrfCoordinator);

            FundSubscription fundSubscription = new FundSubscription();
            fundSubscription.fundSubscription(config.vrfCoordinator, config.subScriptionId, config.link);
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
        AddConsumer addConsumer = new AddConsumer();
        addConsumer.addConsumer(address(raffle), config.vrfCoordinator, config.subScriptionId);
        return (raffle, helperConfig);
    }
}
