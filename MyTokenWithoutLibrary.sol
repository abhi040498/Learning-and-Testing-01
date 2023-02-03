
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17; // version of solidity to use in the contract

//ERC 20 token standards. 
// These are the must have functions in ERC 20.
// interface is where we list all functions are only defined (without implementation).
interface ERC20Interface {
    
    function totalSupply() external view returns (uint); // It defined the total number of tokens. No new tokens will be minted when total suppuly is reached.
    function balanceOf(address account) external view returns (uint balance); //It defines the mumber of token for the given wallet address 
    function allowance(address owner, address spender) external view returns (uint remaining); // It checks if a specific address has enough balance to send tokens to another address.
    function transfer(address recipient, uint amount) external returns (bool success); // It transfer a certain amount of tokens from the total supply and sends to a specific address 
    function approve(address spender, uint amount) external returns (bool success); // It is used to varify whether a smart contract is allowed to allocate a certain number of token to a user considering total supply.
    function transferFrom(address sender, address recipient, uint amount)  external returns (bool success); // It transfers a certain amount of tokens from one address to another address.

    // Events are used as informing services outside of the blockchain to let users know that something has happened.
    event Transfer(address indexed from, address indexed to, uint value); // Inform from where to where and how much token was transfered 
    event Approval(address indexed owner, address indexed spender, uint value); // Inform who was the owner, spender, value that was allowed. 

}


//Actual Token Contract is defined here
contract MyTokenWithoutLibrary is ERC20Interface {
    //First all the variables are defined 
    string public symbol;
    string public name;
    uint8 public decimals;
    uint public _totalSupply;

    //We need to create some mappings so that users gets ability to spend tokens.
    mapping(address => uint) balances; // Mapping of address with number of tokens in it. 
    mapping(address => mapping(address => uint)) allowed; // Mapping of wallets with the address and number of tokens in it.

    // It will be executed when we deploy the smart contract.
    constructor() {
        symbol = "AKC";
        name = "AKC Coin";
        decimals = 18;
        _totalSupply = 1_000_000_000_000_000_000_000_000; 
        balances[0x4C48907eF074ACED07c62e7D68e6681288347338] = _totalSupply;
        emit Transfer(address(0), 0x4C48907eF074ACED07c62e7D68e6681288347338 , _totalSupply);
    }

    function totalSupply() external view returns (uint) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint balance) {
        return balances[account];
    }

    function transfer(address recipient, uint amount) external returns (bool success) {
        balances[msg.sender] = balances[msg.sender] - amount;
        balances[recipient] = balances[recipient] + amount;
        emit Transfer(msg.sender, recipient, amount);
        return  true;
    }

    function approve(address spender, uint amount) external returns (bool success) {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint amount)  external returns (bool success) {
        balances[sender] = balances[sender] - amount;
        allowed[sender][msg.sender] = allowed[sender][msg.sender] - amount;
        balances[recipient] = balances[recipient] + amount;
        emit  Transfer(sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint remaining) {
        return allowed[owner][spender];
    }
}
