// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {FundMeFactory} from "../src/FundMeFactory.sol";
import {FundMeFactoryScript} from "../script/FundMeFactory.s.sol";

contract FundMeTest is Test {
    FundMeFactory public fundMeFactory;
    FundMe public fundMe;
    address public deployedFundMeAddress;
    address public OWNER = makeAddr("player");
    uint256 public constant STARTING_USER_BALANCE = 10 ether;

    function setUp() external {
        FundMeFactoryScript deployScript = new FundMeFactoryScript();
        fundMeFactory = deployScript.run();

    }

    function testContractDeployedSettingOwner() public {
        vm.prank(OWNER);
        fundMeFactory.createFundMeContract();
        deployedFundMeAddress = address(fundMeFactory.getFundMeContract(0));
        fundMe = FundMe(deployedFundMeAddress);
        console.log("factory contract:", address(fundMeFactory));
        assertEq(fundMe.getOwner(), OWNER);
    }
}
