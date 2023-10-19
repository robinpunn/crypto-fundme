// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
    set up a contract factory.

    user should be able to launch a new contract and become owner

    create a mapping that will track donors and amounts

    contract should accept donations

    owner can cancel to return funds
        create a cancel bool so contract can't be withdrawn from

    only owner should be able to withdraw
        use self destruct ???

    import OZ onlyowner??
 */

contract FundMe {
    error FundeMe__NotOwner();

    /**
    * @notice funders key mapped to amount funded
    * @dev mapping updated anytime a user funds contract
    */
    mapping(address => uint256) private s_addressFundedAmount;
    /**
    * @notice array of addresses that have funded the account
    * @dev this array should be updated any time a new user funds contract
    */
    address[] private s_funders;
    /**
    * @notice contract owner
    */
    address payable private immutable i_owner;

    /**
    * @notice Checks if msg.sender is owner
    */
    modifier onlyOwner() {
        if (msg.sender != i_owner) {
            revert FundeMe__NotOwner();
        }
        _;
    }

    /**
    * @notice sets i_owner to msg.sender
    */
    constructor(address payable owner) {
        i_owner = owner;
    }


    /** Getter Functions */
    function getOwner() external view returns(address) {
        return i_owner;
    }
}
