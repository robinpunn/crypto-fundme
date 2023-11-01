# Blockchain Crowdfunding

This is a crowd funding dapp that allows users to donate ethereum to a smart
contract deployed by a user requesting donations

### `FundMeFactory.sol`

#### Deploying a `FundMe` contract

The user deploys a `FundMe` contract with the `FundMeFactory` contract:

```solidity
function createFundMeContract() external {
    FundMe newFundMeContract = new FundMe(payable(msg.sender), address(this));
    s_fundMeContracts[msg.sender] = address(newFundMeContract);

    emit FundMeContractCreation(address(newFundMeContract), msg.sender);
}
```

This contract sends the address of the user deploying the contract and the
address of the contract itself to the newly created `FundMe` contract. The
`FundMe` contract will be able to use the addresses.

#### Tracking Contracts

The factory contract keeps track of all the contracts that have been deployed
associating the contract with the user that deployed the contract:

```solidity
mapping(address owner=> address fundMeContract) private s_fundMeContracts;
```

When a new contract is deployed, an event is emitted that indexes the `FundMe`
contract address and the address of the user that deployed the contract.

```solidity
event FundMeContractCreation(address indexed fundMeContract, address indexed owner);
```

A user that deployed a contract can retrieve the address of the contract by
calling the `getFundMeContract()` function:

```solidity
function getFundMeContract() external view returns (address) {
    address fundMeContract = s_fundMeContracts[msg.sender];
    if (fundMeContract == address(0)) {
        revert FundMeFactory__ContractDeletedOrDoesNotExist();
    }
    return fundMeContract;
}
```

The function will use the address of the user calling the function. If the
function is able to find a contract address from the `s_fundMeContracts`
mapping, that address will be returned.

#### Removing Contracts

When a user/owner withdraws their funds from a `FundMe` contract, the contract
will be deleted from the `s_fundMeContracts` mapping:

```solidity
function removeFundeMeContract(address ownerContract) external {
    if(msg.sender != s_fundMeContracts[ownerContract]) {
        revert FundMeFactory__NotTheOwner();
    }
    delete s_fundMeContracts[ownerContract];
}
```

When a user withdraws, the `FundMe` contract will send this function the user's
address. However, the `msg.sender` will actually be the `FundMe` contract. This
contract will use address parameter to check the `s_fundMeContracts` mapping.
The returned address should match `msg.sender`. If it does match, the `FundMe`
contract will be deleted.

### `FundMe.sol`

When a user wants to start a funding campaign, they ultimately deploy their own
version of this `FundMe` contract. Behind the scenes, the `FundMe` contract is
actually deployed with the help of the `FundMeFactory.sol` contract. That
contract is responsible for deploying contracts and keeping track of which
address deployed which contract.

This contract is responsible for each individual funding campaign. The ownership
of this contract belongs to the address that deployed it.

#### Constructor

The constructor function takes two arguments which are use to set two state
variables.

```solidity
constructor(address payable owner, address factory) {
    i_owner = owner;
    i_factory = factory;
}
```

The constructor sets the owner of the contract:
`address payable private immutable i_owner;`. This address is passed to the
`FundMe` contract from the `FundMeFactory` contract. This address will be the
owner of this specific `FundMe` contract.

The `onlyOwner` modifier ensures only the owner of the contract can performs
certain actions:

```solidity
modifier onlyOwner() {
    if (msg.sender != i_owner) {
        revert FundMe__NotOwner();
    }
     _;
}
```

#### Withdrawing

In this contract, `onlyOwner` is applied to one function, the `withdraw()`
function:

```solidity
function withdraw() external payable onlyOwner {
    if (address(this).balance <= 0) {
        revert FundMe__NoFundsToWithDraw();
    }

    address factory = getFactory();
    FundMeFactory(factory).removeFundeMeContract(msg.sender);

    (bool success,) = i_owner.call{value: address(this).balance}("");
    if (!success) {
        revert FundMe__WithdrawFailed();
    }
}
```

As long as there is a balance, the owner can withdraw the balance of the
contract. The `withdraw()` function also makes a call to the `FundMeFactory`
contract to remove this contract with mapping that tracks contracts.

The `FundMeFactory` contract address, which was passed to the constructor, is
stored as a state variable: `address private immutable i_factory;`. This address
is used to make the call inside the `withdraw()` function. The address of the
owner is passed as an argument to the `removeFundMeContract()` function in
`FundMeFactory`

#### Donating

Users can donate to the contract using the `donation()` function:

```solidity
function donate() external payable {
    if (msg.value <= 0) {
        revert FundMe__InvalidDonationAmount();
    }

    (bool success,) = payable(address(this)).call{value: msg.value}("");
        if (!success) {
            revert FundMe__DonationFailed();
    }

    s_funderAmounts[msg.sender] += msg.value;

    emit ContractFunded(msg.sender, msg.value);
}
```

Users must donate a value larger than 0. The donation amount is sent to the
contract, and the address of the sender is added to the mapping that tracks
funders:
`mapping(address funder => uint256 amountFunded) private s_funderAmounts;`

#### TLDR

Users can deploy `FundMe` contracts which are managed by the `FundMeFactory`
contract. The user that deployed the `FundMe` contract is the owner of that
contract. Anyone can donate to the `FundMe` contract and only the owner can
withdraw from the contract.
