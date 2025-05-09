// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

// Importamos el contrato HolaMundo que vamos a desplegar
import {HolaMundo} from "../src/HolaMundo.sol";

// Definimos un error personalizado para revertir transacciones
error ThrowError();

contract Factory {
    // Variable que almacenará la dirección del contrato HolaMundo desplegado
    HolaMundo public holaMundo;
    
    // Evento que se emite cuando se despliega un nuevo contrato
    // indexed permite filtrar eventos por la dirección del contrato
    event Reverting(address indexed newContract);

    // Función que despliega un nuevo contrato HolaMundo
    // external: solo puede ser llamada desde fuera del contrato
    // returns: devuelve un string con el mensaje de éxito
    function deploy() external returns (string memory) {
        // Desplegamos un nuevo contrato HolaMundo
        HolaMundo newContract = new HolaMundo();
        // Guardamos la referencia al contrato desplegado
        holaMundo = newContract;
        // Emitimos el evento con la dirección del nuevo contrato
        emit Reverting(address(holaMundo));
        return "Contrato desplegado";
    }

    // Función que revierte la transacción con un error personalizado
    // pure: no lee ni modifica el estado del contrato
    function revertFunction() external pure {
        revert ThrowError();
    }
}