// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// Importamos las utilidades de test de Forge
import {Test, console2} from "forge-std/Test.sol";
// Importamos el contrato que vamos a probar
import {HolaMundo} from "../src/HolaMundo.sol";

// El contrato de test debe heredar de Test
contract HolaMundoTest is Test {
    // Variable que almacenará la instancia del contrato a probar
    HolaMundo public holaMundo;

    // Función que se ejecuta antes de cada test
    // Crea una nueva instancia del contrato para cada test
    function setUp() public {
        holaMundo = new HolaMundo();
    }

    // Test que verifica que el saludo sea el esperado
    // assertEq compara dos valores y falla si son diferentes
    function testSaludo() view public {
      assertEq(holaMundo.saludo(), "Hola Mundo!");
    }
}
