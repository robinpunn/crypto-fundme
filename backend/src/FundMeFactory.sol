// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import {FundMe} from "./FundMe.sol";

contract FundMeFactory {
    // list of deployed contracts
    FundMe[] private s_listOfFundMeContracts;   

    function createFundMeContract() external {
        FundMe fundMeContract = new FundMe();
        s_listOfFundMeContracts.push(fundMeContract);
    }

}