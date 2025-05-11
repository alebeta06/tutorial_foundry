// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Counter2} from "../src/Counter2.sol";

contract CounterTest is Test {
    Counter2 public counter;

    function setUp() public {
        counter = new Counter2();
        counter.setNumber(0);
    }

    // Test para incrementar el contador
    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }
    
    // Test para establecer el número
    function testFuzz_SetNumber(uint256 x) public {
        //vm.skip(true);
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }    

    // Invariant para verificar que el total es mayor o igual al número
    function invariant_SetNumberAndTotal() view public {  
        assertGe(counter.total(), counter.number());
    }

}