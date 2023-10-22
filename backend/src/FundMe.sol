// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import {FundMeFactory} from "./FundMeFactory.sol";

contract FundMe {
    error FundMe__NotOwner();
    error FundMe__DonationFailed();
    error FundMe__WithdrawFailed();

    /**
    * @notice funders key mapped to amount funded
    * @dev mapping updated anytime a user funds contract
    */
    mapping(address funder=> uint256 amountFunded) private s_funderAmounts;

    /**
    * @notice contract owner
    */
    address payable private immutable i_owner;

    /**
    * @notice factory contract
    */
    address private immutable i_factory;

    /**
    * @notice Event when contract is funded
    */
    event ContractFunded(address indexed funder, uint256 indexed amountFunded);

    /**
    * @notice Checks if msg.sender is owner
    */
    modifier onlyOwner() {
        if (msg.sender != i_owner) {
            revert FundMe__NotOwner();
        }
        _;
    }

    /**
    * @notice sets i_owner to msg.sender
    */
    constructor(address payable owner, address factory) {
        i_owner = owner;
        i_factory = factory;
    }

    receive() external payable {}

    function donate() external payable {
        (bool success, ) = payable(address(this)).call{value: msg.value}("");
        if (!success) {
            revert FundMe__DonationFailed();
        }

        s_funderAmounts[msg.sender] += msg.value;

        emit ContractFunded(msg.sender, msg.value);
    }

    function withdraw() external payable onlyOwner() {
        address factory = getFactory();
        FundMeFactory(factory).removeFundeMeContract(address(this));
        (bool success, ) = i_owner.call{value: address(this).balance}("");
        if (!success) {
            revert FundMe__WithdrawFailed();
        }
    }

    /** Getter Functions */
    /**
    * @notice returns the owner of the contract
    */
    function getOwner() external view returns(address) {
        return i_owner;
    }
    /**
    * @notice returns the balance of the contract
    */
    function getBalance() external view returns(uint256) {
        return address(this).balance;
    }

    /**
    * @notice returns the address of the deployer contract factory
    */
    function getFactory() public view returns(address) {
        return i_factory;
    }

}
