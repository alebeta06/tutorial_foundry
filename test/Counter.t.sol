// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import  "forge-std/Test.sol";
import {HelperContract} from "../src/HelperContract.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test, HelperContract {
    Counter public counter;
    uint256 testNumber;
    address importantAddress;

    function setUp() public {
        counter = new Counter();
        testNumber = 42;
        importantAddress =  0x377307274977ac9E3b2b71BEaA8a1aC859FB1097;
    }

    function test_ImportantAddress() public {
        assertEq(importantAddress, HelperContract.IMPORTANT_ADDRESS);
    }

    function test_NumberIs42() public {
        assertEq(testNumber, 42);
    }
    function testFail_Substract43() public {
        testNumber -= 43;
    }

    function test_Getcontador() public {
        uint256 contadorValue = counter.getContador();
        assertEq(contadorValue, 0);
    }

    function test_Incrementa() public {
        counter.incrementa();
        uint256 contadorValue = counter.getContador();
        assertEq(contadorValue, 1);
    }

    function testFail_reduce() public {
        counter.reduce();

    }
}    