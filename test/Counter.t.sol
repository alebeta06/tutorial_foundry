// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Importamos las utilidades de test y console para logging
import {Test, console } from "forge-std/Test.sol";
// Importamos el contrato Counter que vamos a probar
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    // Instancia del contrato Counter que vamos a probar
    Counter public counter;

    // Función que se ejecuta antes de cada test
    // Crea una nueva instancia del contrato para cada test
    function setUp() public {
        counter = new Counter();
    }

    // Test que verifica el incremento del contador
    // console.log se usa para imprimir mensajes durante la ejecución del test
    function test_Increment() public {
        // Incrementamos el contador
        counter.increment();
        // Imprimimos un mensaje con el número 256 (esto parece ser un ejemplo)
        console.log("imprime el siguiente numero :", 256);
        // Verificamos que el contador sea 1 después del incremento
        assertEq(counter.contador(), 1);
    }
}