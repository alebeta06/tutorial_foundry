// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console } from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    
    }

    function test_Increment() public {
        counter.increment();
        console.log("imprime el siguiente numero :", 256);
        assertEq(counter.contador(), 1);
    }
}