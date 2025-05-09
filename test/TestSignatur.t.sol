// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

contract TestSign is Test {
    function testSignMessage() public {
        (address alejandro, uint256 privateKey) = makeAddrAndKey("alejandro");
        emit log_address(alejandro);
        emit log_uint(privateKey);

        bytes32 messageHashed = keccak256("firmado por alejandro");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messageHashed);
        address signer = ecrecover(messageHashed, v, r, s);
        assertEq(signer, alejandro);
    }
}
