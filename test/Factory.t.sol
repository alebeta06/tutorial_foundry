// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import {Test} from "forge-std/Test.sol";
import {Factory} from "../src/Factory.sol";

contract FactoryTest is Test {
    /*
    // Verde: para las llamadas que no revierten
    // Rojo: para las llamadas que revierten
    // Azul: para las llamadas a los cheatcodes
    // Cyan: para los logs/ eventos emitidos
    // Amarillo: para el despliegue de contratos
    */

    // Instancia del contrato Factory que vamos a probar
    Factory public factory;

    // Función que se ejecuta antes de cada test
    // Crea una nueva instancia del contrato para cada test
    function setUp() public{
        factory = new Factory();
    }

    // Test que verifica el despliegue exitoso del contrato
    // vm.prank se usa para simular una llamada desde una dirección específica
    function test_Deploy() public{
        // Simulamos una llamada desde la dirección 0
        vm.prank(address(0));
        string memory result = factory.deploy();
        // Verificamos que el resultado sea el esperado
        assertEq(result, "Contrato desplegado");
    }

    // Test que verifica que la función revierte cuando no es llamada por el owner
    // vm.expectRevert espera que la transacción revierta
    function test_RevertWhen_NotOwner() public {
        // Simulamos una llamada desde la dirección 0 (no owner)
        vm.prank(address(0));
        vm.expectRevert();
        factory.revertFunction();
    }
}