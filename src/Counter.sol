// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public contador;

    function getContador() public view returns (uint256) {
        return contador;
    }

    function increment() public {
        contador+= 1;
    }

    function reduce() public {
        contador -= 1;
    }
}
