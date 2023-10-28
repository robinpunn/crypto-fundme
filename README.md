# Blockchain Crowdfunding
This is a crowd funding dapp that allows users to donate ethereum to a smart contract deployed by a user requesting donations

### FundMeFactory
The user deploys a ``FundMe`` contract with the ``FundMeFactory`` contract:
```solidity
function createFundMeContract() external {
    FundMe newFundMeContract = new FundMe(payable(msg.sender), address(this));
    s_fundMeContracts[msg.sender] = address(newFundMeContract);

    emit FundMeContractCreation(address(newFundMeContract), msg.sender);
}
```
This contract sends the address of the user deploying the contract and the address of the contract itself to the newly created ``FundMe`` contract.  The ``FundMe`` contract will be able to use the addresses.

The factory contract keeps track of all the contracts that have been deployed associating the contract with the user that deployed the contract:
```solidity
mapping(address owner=> address fundMeContract) private s_fundMeContracts;
```

When a new contract is deployed, an event is emitted that indexes the ``FundMe`` contract address and the address of the user that deployed the contract.
```solidity
event FundMeContractCreation(address indexed fundMeContract, address indexed owner);
```

A user that deployed a contract can retrieve the address of the contract by calling the ``getFundMeContract()`` function:
```solidity
function getFundMeContract() external view returns (address) {
    address fundMeContract = s_fundMeContracts[msg.sender];
    if (fundMeContract == address(0)) {
        revert FundMeFactory__ContractDeletedOrDoesNotExist();
    }
    return fundMeContract;
}
```
The function will use the address of the user calling the function. If the function is able to find a contract address from the ``s_fundMeContracts`` mapping, that address will be returned.

When a user/owner withdraws their funds from a ``FundMe`` contract, the contract will be deleted from the ``s_fundMeContracts`` mapping:
```solidity
function removeFundeMeContract(address ownerContract) external {
    if(msg.sender != s_fundMeContracts[ownerContract]) {
        revert FundMeFactory__NotTheOwner();
    }
    delete s_fundMeContracts[ownerContract];
}
```
When a user withdraws, the ``FundMe`` contract will send this function the user's address. However, the ``msg.sender`` will actually be the ``FundMe`` contract. This contract will use address parameter to check the ``s_fundMeContracts`` mapping. The returned address should match ``msg.sender``. If it does match, the ``FundMe`` contract will be deleted.
