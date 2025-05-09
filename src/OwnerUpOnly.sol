// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

// Error personalizado que se lanza cuando un usuario no autorizado intenta incrementar
error Unauthorized();

contract OwnerUpOnly {
    // Dirección del owner del contrato, marcada como immutable para optimizar gas
    address public immutable owner;
    // Contador que solo puede ser incrementado por el owner
    uint256 public count;
    // Evento que se emite cuando se incrementa el contador
    // indexed permite filtrar eventos por la dirección del sender
    event Caller(address indexed sender);

    // Constructor que establece el owner como el deployer del contrato
    constructor() {
        owner = msg.sender;
    }

    // Función que incrementa el contador
    // external: solo puede ser llamada desde fuera del contrato
    // Solo el owner puede llamar a esta función
    function increment() external {
        // Verificamos que el caller sea el owner
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        count++;
    }

    // Función que incrementa el contador y emite un evento
    // Esta función puede ser llamada por cualquier dirección
    // Se usa para demostrar el uso de startPrank y stopPrank en los tests
    function incrementNotOwner() external {
        count++;
        // Emitimos el evento con la dirección del caller
        emit Caller(msg.sender);
    }
}
