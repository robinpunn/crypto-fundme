// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import {FundMe} from "./FundMe.sol";

contract FundMeFactory {
    error FundMeFactory__OnlyOneContractPerUser();
    error FundMeFactory__ContractDeletedOrDoesNotExist();
    error FundMeFactory__NotTheOwner();

    /**
     * @notice owner key mapped to deployed
     * @dev the createFundMeContract() function will update this mapping when executed
     */
    mapping(address owner => address fundMeContract) private s_fundMeContracts;

    event FundMeContractCreation(address indexed fundMeContract, address indexed owner);

    /**
     * @notice a function to deploy a contract
     * @dev this function will use msg.sender as an argument for the FundMe contract constructor
     */
    function createFundMeContract() external {
        if (s_fundMeContracts[msg.sender] != address(0)) {
            revert FundMeFactory__OnlyOneContractPerUser();
        }

        FundMe newFundMeContract = new FundMe(
            payable(msg.sender),
            address(this)
        );
        s_fundMeContracts[msg.sender] = address(newFundMeContract);

        emit FundMeContractCreation(address(newFundMeContract), msg.sender);
    }

    /**
     * @notice a function to retreive a deployed contract address
     * @dev this function will use msg.sender to check if an associated deployed address exists
     */
    function getFundMeContract() external view returns (address) {
        address fundMeContract = s_fundMeContracts[msg.sender];
        if (fundMeContract == address(0)) {
            revert FundMeFactory__ContractDeletedOrDoesNotExist();
        }
        return fundMeContract;
    }

    /**
     * @notice a function to remove contract from mapping
     * @dev this function will use msg.sender (the contract calling the function) as a check to compare with mapping
     * @param ownerAddress will be the address of the owner, but msg.sender will be the FundMe contract address
     */
    function removeFundeMeContract(address ownerAddress) external {
        if (msg.sender != s_fundMeContracts[ownerAddress]) {
            revert FundMeFactory__NotTheOwner();
        }
        delete s_fundMeContracts[ownerAddress];
    }
}
