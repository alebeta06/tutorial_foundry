pragma solidity ^0.8.10;

import "solmate/tokens/ERC20.sol";

contract Token is ERC20 {

    constructor() ERC20("Foundry Esp", "FES", 18) {}
}