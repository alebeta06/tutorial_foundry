// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/Test.sol";
import {OwnerUpOnly} from "../src/OwnerUpOnly.sol";

// Definición del error personalizado que se usará en el contrato
error Unauthorized();

contract OwnerUpOnlyTest is Test {
    // Instancia del contrato que vamos a probar
    OwnerUpOnly upOnly;
    
    // Evento que se emitirá para rastrear quién llama a las funciones
    event Caller(address indexed sender);

    // Función que se ejecuta antes de cada test
    // Crea una nueva instancia del contrato para cada test
    function setUp() public {
        upOnly = new OwnerUpOnly();
    }
    
    // Test básico que verifica el incremento como owner
    // vm.skip(true) indica que este test será saltado
    function test_IncrementAsOwner() public {
        vm.skip(true);
        assertEq(upOnly.count(), 0);
        upOnly.increment();
        assertEq(upOnly.count(), 1);
    }

    // Test que verifica que usuarios no-owner no pueden incrementar
    // vm.expectRevert espera que la transacción revierta
    // vm.prank simula una llamada desde una dirección específica
    function test_RevertWhen_CallerIsNotOwner() public {
        vm.skip(true);
        vm.expectRevert(Unauthorized.selector);
        vm.prank(address(0));
        upOnly.increment();
    }
    
    // Test que demuestra el uso de vm.prank
    // prank solo afecta a la siguiente llamada
    function test_CallerIsOwnerPrank() public {                                
        vm.prank(address(1));     

        // vm.expectEmit verifica que se emita un evento específico
        // Los parámetros indican qué partes del evento verificar
        vm.expectEmit(true, false, false, false);  
        emit Caller(address(1));
        upOnly.incrementNotOwner();

        // Después de la primera llamada, el caller vuelve a ser el contrato de test
        vm.expectEmit(true, false, false, false);  
        emit Caller(address(this));
        upOnly.incrementNotOwner();                
    }
        
    // Test que demuestra el uso de startPrank/stopPrank
    // startPrank mantiene el caller hasta que se llame a stopPrank
    function test_CallerIsOwner() public {
        // Establece el caller para todas las llamadas siguientes
        vm.startPrank(address(1));        
        
        // Verifica que se emita el evento con el caller correcto
        vm.expectEmit(true, false, false, false);
        emit Caller(address(1));
        upOnly.incrementNotOwner();  

        // El caller sigue siendo address(1)
        vm.expectEmit(true, false, false, false);
        emit Caller(address(1)); 
        upOnly.incrementNotOwner();    

        // Detiene el prank, el caller vuelve a ser el contrato de test
        vm.stopPrank();

        // Verifica que el caller haya vuelto a ser el contrato de test
        vm.expectEmit(true, false, false, false);
        emit Caller(address(this)); 
        upOnly.incrementNotOwner();                  
    }
}
