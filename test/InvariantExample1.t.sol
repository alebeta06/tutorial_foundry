// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

// Importamos las bibliotecas necesarias para testing
import {Test} from "forge-std/Test.sol";  // Biblioteca de testing de Foundry
import {ExampleContract1} from "../src/ExampleContract1.sol";  // Importamos el contrato que vamos a probar

// Definimos el contrato de prueba que hereda de Test
contract InvariantExample1 is Test {
    // Declaramos una variable para instanciar nuestro contrato a probar
    ExampleContract1 foo;

    // Función setUp que se ejecuta antes de cada prueba
    // Es una función especial de Foundry que se ejecuta automáticamente
    function setUp() public {
        // Creamos una nueva instancia del contrato ExampleContract1
        foo = new ExampleContract1();
    }

    // Invariante A: Verifica que  value3 siempre sea la suma exacta de value1 y value2, lo cual es crucial para la lógica del contrato.
    // Este es un invariante importante porque value3 actúa como contador total
    // Se ejecutará múltiples veces durante las pruebas de fuzzing
    // assertEq significa "assert equal" (asegurar igual)
    function invariant_A() view external {
        assertEq(foo.value1() + foo.value2(), foo.value3());
    }

    // Invariante B: Verifica que la suma de value1 y value2 siempre sea mayor o igual que value1
    // Este es un invariante matemático básico que siempre debe cumplirse
    // assertGe significa "assert greater or equal" (asegurar mayor o igual)
    function invariant_B() view external {
        assertGe(foo.value1() + foo.value2(), foo.value1());
    }
}