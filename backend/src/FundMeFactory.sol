// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import {FundMe} from "./FundMe.sol";

contract FundMeFactory {
    // list of deployed contracts
    FundMe[] private s_listOfFundMeContracts;   
    event FundMeContractCreation(address indexed fundMeContract, address indexed owner);

    function createFundMeContract() external {
        FundMe newFundMeContract = new FundMe(payable(msg.sender));
        s_listOfFundMeContracts.push(newFundMeContract);

        emit FundMeContractCreation(address(newFundMeContract), msg.sender);
    }

    function getFundMeContract(uint index) external view returns (FundMe) {
        require(index < s_listOfFundMeContracts.length, "Index out of bounds");
        return s_listOfFundMeContracts[index];
    }

}