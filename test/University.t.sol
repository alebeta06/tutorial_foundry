// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import {Test, console} from "forge-std/Test.sol";
import {University} from "../src/University.sol";

contract UniversityTest is Test {
    // Instancia del contrato que vamos a probar
    University public university;
    // Variable para almacenar la fecha de inicio de las inscripciones
    uint256 private startDate;

    // Cheatcodes para manipular el tiempo en Forge:
    // vm.warp - establece block.timestamp a un valor específico    
    // skip - incrementa el tiempo actual en segundos
    // rewind - reduce el tiempo actual en segundos
    
    function setUp() public {
        university = new University();
        // Guardamos el timestamp actual como fecha de inicio
        startDate = block.timestamp;
    }

    // Test que verifica que no se puede inscribir antes de la fecha de inicio
    // vm.expectRevert espera que la transacción revierta con el mensaje "cannot enroll"
    function testEnrollFailBeforeStartDate() public {
        vm.expectRevert("cannot enroll");
        university.enroll();
    }

    // Test que verifica que no se puede inscribir después de la fecha límite
    // vm.warp se usa para simular que han pasado 2 días desde la fecha de inicio
    function testEnrollFailBeforeEndDate() public {
        vm.expectRevert("cannot enroll");
        // Avanzamos 2 días desde la fecha de inicio
        vm.warp(startDate + 2 days);
        university.enroll();
    }

    // Test que verifica la inscripción exitosa durante el período permitido
    // vm.warp se usa para simular que ha pasado 1 día desde la fecha de inicio
    function testEnroll() public {
        // Avanzamos 1 día desde la fecha de inicio (dentro del período permitido)
        vm.warp(startDate + 1 days);
        university.enroll();
    }

    // Test que verifica que se puede dar de baja después del período de inscripción
    // vm.warp se usa para simular que han pasado 2 días y 1 segundo desde la fecha de inicio
    function testLeave() public {
        // Avanzamos 2 días y 1 segundo (después del período de inscripción)
        vm.warp(startDate + 2 days + 1 seconds);
        university.leave();
    }

    // Test que demuestra el uso de skip para avanzar el tiempo
    // skip se usa para avanzar el tiempo en segundos
    function testSkip() public {
        // Establecemos el timestamp a 0
        vm.warp(0);
        assertEq(block.timestamp, 0);
        // Avanzamos 1 hora (3600 segundos)
        skip(3600); 
        assertEq(block.timestamp, 3600);
    }

    // Test que demuestra el uso de rewind para retroceder el tiempo
    // rewind se usa para retroceder el tiempo en segundos
    function testRewind() public {
        // Retrocedemos 1 segundo
        rewind(1);
        assertEq(block.timestamp, 0);
    }
}
