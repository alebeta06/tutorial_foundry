// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter2 {
    uint256 public number;
    uint256 public total = 80;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
        total += newNumber;
    }
    
    function increment() public {
        number++;
    }
    
    
}

//en otra terminal
//~/tutorial_foundry$ anvil
//para iniciar el nodo local y octener la private key

//:~/tutorial_foundry$ forge create Counter2 --private-key <private-key> --broadcast

//Transaction: 0x4d00d46ce455b184c970ce28cb0c917f0f761541636f8c6089e2c7e3db8305ef
//Contract created: 0x700b6A60ce7EaaEA56F065753d8dcB9653dbAD35
//Gas used: 205389

//:~/tutorial_foundry$ cast call 0x700b6A60ce7EaaEA56F065753d8dcB9653dbAD35 "total()"
//0x0000000000000000000000000000000000000000000000000000000000000050 (es el total 80)