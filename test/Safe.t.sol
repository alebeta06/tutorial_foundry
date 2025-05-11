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
        emit log_uint(address(this).balance);
        // Esto es lo maximo que tiene por defecto esta cuenta
        // 79228162514264337593543950335
        payable(address(safe)).transfer(1 ether);        
        uint256 prebalance = address(this).balance;
        safe.withdraw();
        uint256 postBalance = address(this).balance;
        assertEq(prebalance + 1 ether, postBalance);
    }

    // uint96 Correcto
    // uint256 Error se desborda
    /// forge-config: default.fuzz.runs = 300
    function test_Withdraw_Fuzz(uint96 amount) public {
        payable(address(safe)).transfer(amount);        
        uint256 prebalance = address(this).balance;
        safe.withdraw();
        uint256 postBalance = address(this).balance;
        assertEq(prebalance + amount, postBalance);
    }
}

// [PASS] test_Withdraw_Fuzzy(uint96) (runs: 257, μ: 22784, ~: 23045) 
// runs: 257 -> se refiere a la cantidad de escenarios que el fuzzer testeó, por defecto 256
// μ: 22784 -> significa la media/promedio utilizado através de todos los fuzz ejecutados
// ~: 23045 -> es la mediana de gas utilizada

//despues lo configuramos a 300 y vemos que pasa
