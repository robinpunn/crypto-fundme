// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

/**
    owner can cancel to return funds
        create a cancel bool so contract can't be withdrawn from

    only owner should be able to withdraw
        use self destruct ???

    import OZ onlyowner??
 */

contract FundMe {
    error FundMe__NotOwner();
    error FundMe__DonationFailed();

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
    constructor(address payable owner) {
        i_owner = owner;
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

    /** Getter Functions */
    function getOwner() external view returns(address) {
        return i_owner;
    }

    function getBalance() external view returns(uint256) {
        return address(this).balance;
    }
}
