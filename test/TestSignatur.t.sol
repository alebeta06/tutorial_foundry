// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

contract TestSign is Test {
    // Función que prueba la firma de mensajes usando makeAddrAndKey
    function testSignMessage() public {
        vm.skip(true); // Esta línea hace que la prueba se salte durante la ejecución
        // makeAddrAndKey genera una dirección y clave privada basadas en el string "alejandro"
        // La dirección y clave serán las mismas cada vez que ejecutes la prueba
        (address alejandro, uint256 privateKey) = makeAddrAndKey("alejandro");
        emit log_address(alejandro); // Muestra la dirección generada en los logs
        emit log_uint(privateKey);   // Muestra la clave privada en los logs

        // Hashea el mensaje que queremos firmar
        bytes32 messageHashed = keccak256("firmado por alejandro");
        // vm.sign firma el mensaje usando la clave privada y retorna los componentes v, r, s
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messageHashed);
        // erecover verifica la firma y recupera la dirección del firmante
        address signer = ecrecover(messageHashed, v, r, s);
        // Verifica que la dirección recuperada coincide con la del firmante
        assertEq(signer, alejandro);
    }

    // Función que prueba la firma de mensajes usando createWallet
    function testSignMessageWallet() public {
        // createWallet crea una wallet con una dirección y clave privada
        // Es similar a makeAddrAndKey pero con una implementación diferente
        address alejandro = vm.createWallet("alejandro").addr;
        uint256 privateKey = vm.createWallet("alejandro").privateKey;
        
        // El proceso de firma es el mismo que en la función anterior
        bytes32 messageHashed = keccak256("firmado por alejandro");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messageHashed);
        address signer = ecrecover(messageHashed, v, r, s);
        assertEq(signer, alejandro);
    }
}
