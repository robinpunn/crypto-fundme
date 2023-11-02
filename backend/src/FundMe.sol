// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import {FundMeFactory} from "./FundMeFactory.sol";

contract FundMe {
    //////////////
    // Errors  ///
    //////////////
    error FundMe__NotOwner();
    error FundMe__InvalidDonationAmount();
    error FundMe__DonationFailed();
    error FundMe__NoFundsToWithDraw();
    error FundMe__WithdrawFailed();
    error FundMe__AddressHasNotFundedContract();

    ////////////////////////
    // State Variables  ///
    ///////////////////////
    /**
     * @notice funders key mapped to amount funded
     * @dev mapping updated anytime a user funds contract
     */
    mapping(address funder => uint256 amountFunded) private s_funderAmounts;

    /**
     * @notice contract owner
     */
    address payable private immutable i_owner;

    /**
     * @notice factory contract address
     */
    address private immutable i_factory;

    ///////////////
    // Events  ///
    //////////////
    /**
     * @notice Event when contract is funded
     */
    event ContractFunded(address indexed funder, uint256 indexed amountFunded);

    /**
     * @notice Event when contract is funded
     */
    event FundsWithdrawn(
        address indexed owner,
        uint256 indexed amountWithdrawn
    );

    /////////////////
    // Modifiers  ///
    /////////////////
    /**
     * @notice Checks if msg.sender is owner
     */
    modifier onlyOwner() {
        if (msg.sender != i_owner) {
            revert FundMe__NotOwner();
        }
        _;
    }

    ///////////////////
    // Constructor  ///
    ///////////////////
    /**
     * @notice sets i_owner to msg.sender
     */
    constructor(address payable owner, address factory) {
        i_owner = owner;
        i_factory = factory;
    }

    ////////////////
    // Fallback  ///
    ////////////////
    receive() external payable {}

    /////////////////
    // Functions  ///
    /////////////////
    /**
     * @notice function to donate to contract
     * @dev the function will add msg.sender and the amount to the s_funderAmount mapping
     */
    function donate() external payable {
        if (msg.value <= 0) {
            revert FundMe__InvalidDonationAmount();
        }
        (bool success, ) = payable(address(this)).call{value: msg.value}("");
        if (!success) {
            revert FundMe__DonationFailed();
        }

        s_funderAmounts[msg.sender] += msg.value;

        emit ContractFunded(msg.sender, msg.value);
    }

    function withdraw() external payable onlyOwner {
        if (address(this).balance <= 0) {
            revert FundMe__NoFundsToWithDraw();
        }
        address factory = getFactory();
        uint256 amount = address(this).balance;

        FundMeFactory(factory).removeFundeMeContract(msg.sender);
        (bool success, ) = i_owner.call{value: amount}("");
        if (!success) {
            revert FundMe__WithdrawFailed();
        }

        emit FundsWithdrawn(msg.sender, amount);
    }

    ////////////////////////
    // Getter Functions  ///
    ////////////////////////
    /**
     * @notice returns the owner of the contract
     */
    function getOwner() external view returns (address) {
        return i_owner;
    }

    /**
     * @notice returns the balance of the contract
     */

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    /**
     * @notice returns the balance from s_funderAmounts using address parameter
     */
    function getFunderBalance(address funder) external view returns (uint256) {
        if (s_funderAmounts[funder] == 0) {
            revert FundMe__AddressHasNotFundedContract();
        }
        return s_funderAmounts[funder];
    }

    /**
     * @notice returns the address of the deployer contract factory
     */
    function getFactory() public view returns (address) {
        return i_factory;
    }
}
