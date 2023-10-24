// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {FundMeFactory} from "../src/FundMeFactory.sol";
import {FundMeFactoryScript} from "../script/FundMeFactory.s.sol";

contract FundMeTest is Test {
    FundMeFactory public fundMeFactory;
    FundMe public fundMe;
    address public deployedFundMeAddress;
    address public OWNER = makeAddr("player");
    address public FUNDER1 = makeAddr("funder1");
    uint256 public constant STARTING_USER_BALANCE = 10 ether;

    event FundMeContractCreation(address indexed fundMeContract, address indexed owner);
    event ContractFunded(address indexed funder, uint256 indexed amountFunded);

    function setUp() external {
        FundMeFactoryScript deployScript = new FundMeFactoryScript();
        fundMeFactory = deployScript.run();
        vm.deal(OWNER,STARTING_USER_BALANCE);
        vm.deal(FUNDER1,STARTING_USER_BALANCE);
    }

    modifier ownerDeploysContractSetContractVariable() {
        vm.prank(OWNER);
        fundMeFactory.createFundMeContract();
        vm.prank(OWNER);
        deployedFundMeAddress = fundMeFactory.getFundMeContract();
        fundMe = FundMe(payable(deployedFundMeAddress));
        _;
    }

    function testDeployment() public {
        assertNotEq(address(fundMeFactory), address(0));
    }

    function testEventEmittedAfterCreatingContract() public {
        vm.expectEmit(true,true, false, false, address(fundMeFactory));
        emit FundMeContractCreation(address(0xd04404bcf6d969FC0Ec22021b4736510CAcec492), OWNER);
        vm.prank(OWNER);
        fundMeFactory.createFundMeContract();
    }

    function testContractDeployedSettingOwner() public ownerDeploysContractSetContractVariable {
        assertEq(fundMe.getOwner(), OWNER);
    }

    function testGetFactoryShouldReturnFactoryAddress() public ownerDeploysContractSetContractVariable {
        assertEq(fundMe.getFactory(), address(fundMeFactory));
    }

    function testZeroBalanceWhenDeployed() public ownerDeploysContractSetContractVariable {
        assertEq(fundMe.getBalance(), 0);
    }

    function testShouldNotBeAbletoDonateZero() public ownerDeploysContractSetContractVariable {
        vm.expectRevert(FundMe.FundMe__InvalidDonationAmount.selector);
        vm.prank(FUNDER1);
        fundMe.donate{value: 0}();
    }

    function testDonatingToContract() public ownerDeploysContractSetContractVariable {
        vm.prank(FUNDER1);
        fundMe.donate{value:1 ether}();
        assertEq(fundMe.getBalance(), 1 ether);
    }

    function testDonatingShouldEmitEvent() public ownerDeploysContractSetContractVariable {
        vm.expectEmit(true, true, false, false);
        emit ContractFunded(FUNDER1, 1 ether);
        vm.prank(FUNDER1);
        fundMe.donate{value:1 ether}();
    }

    function testDonateShouldUpdateFunderAmountsMapping() public ownerDeploysContractSetContractVariable {
        vm.prank(FUNDER1);
        fundMe.donate{value:1 ether}();
        vm.prank(FUNDER1);
        fundMe.donate{value:1 ether}();
        assertEq(fundMe.getFunderBalance(FUNDER1), 2 ether);
    }

}
