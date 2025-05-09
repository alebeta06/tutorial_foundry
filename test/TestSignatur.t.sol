// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

contract TestSign is Test {
    function testSignMessage() public {
        (address alejandro, uint256 privateKey) = makeAddrAndKey("alejandro");
        emit log_address(alejandro);
        emit log_uint(privateKey);
    }
}
