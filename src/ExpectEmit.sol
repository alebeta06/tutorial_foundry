// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract ExpectEmit {
    //Evento Transfer
    event Transfer(address indexed from, address indexed to, uint256 value);

    //Funcion que solo emite el evento transfer
    function t() public {
        emit Transfer(msg.sender, address(1337), 1337);
    }
}
