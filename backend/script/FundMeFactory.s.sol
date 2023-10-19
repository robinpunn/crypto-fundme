// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {FundMeFactory} from "../src/FundMeFactory.sol";

contract FundMeFactoryScript is Script {
    function run() external returns(FundMeFactory) {
        vm.startBroadcast();
        FundMeFactory fundMeFactory = new FundMeFactory();
        vm.stopBroadcast();
        return fundMeFactory;
    }
}
