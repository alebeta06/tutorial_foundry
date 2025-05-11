// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Safe} from "../src/Safe.sol";

contract SafeTest is Test {
    Safe safe;

    receive() external payable{}

    function setUp() public {
        safe = new Safe();
    }

    function test_Withdraw() public {
        payable(address(safe)).transfer(1 ether);        
        uint256 prebalance = address(this).balance;
        safe.withdraw();
        uint256 postBalance = address(this).balance;
        assertEq(prebalance + 1 ether, postBalance);
    }
}