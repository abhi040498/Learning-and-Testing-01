
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0; // version of solidity to use in the contract
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";  //Importing a library that has pre-bui;d ERC 20 token files

//Now we need to create a contract that uses ERC 20 to build token.
//This token has a contructor function with parameter Coin name and coin symbol.
// then we have to mint the token so that it can be out for supply/use.
//decimal() is used without a parameter as it will use default decimal places of ERC 20 token. 
contract MyToken is ERC20 {
    constructor () ERC20("Ak Coin", "Akcoin") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
        }
    }