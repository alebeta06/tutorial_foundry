// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.30;

import "forge-std/Test.sol";

// Interfaz para interactuar con el contrato WETH (Wrapped Ether)
// WETH es una versión tokenizada de ETH que sigue el estándar ERC20
interface IWETH {
    function balanceOf(address) external view returns(uint256);
    function deposit() external payable;  // Función para convertir ETH a WETH
}

// Interfaz para interactuar con el contrato DAI (stablecoin)
interface IDAI {    
    function balanceOf(address) external view returns(uint256);
    function totalSupply()  external view returns(uint256);
}

contract ForkingTest is Test {    
    // Direcciones de los contratos en mainnet
    // DAI Address: 0x6B175474E89094C44Da98b954EedeAC495271d0F    
    // RPC ENDPOINT - Alchemy prefijo : https://eth-mainnet.g.alchemy.com/v2/
    IWETH public WETH;
    IDAI public DAI;
    
    // setUp se ejecuta antes de cada test
    // Aquí inicializamos las interfaces con las direcciones de los contratos reales
    function setUp() public {
        WETH = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);    
        DAI = IDAI(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    }

    // Test para verificar la funcionalidad de depositar ETH y recibir WETH
    function testDepositEtherMintWETH() public {
        //vm.skip(true);  // Este test está temporalmente deshabilitado
        // vm.deal es una función de Foundry que nos permite dar ETH a una dirección
        vm.deal(address(this), 1 ether);
        
        // Verificamos el balance inicial de WETH
        uint256 balance = WETH.balanceOf(address(this));
        emit log_uint(balance);

        // Depositamos 1 ETH para recibir WETH
        WETH.deposit{ value : 1 ether }();
        
        // Verificamos el balance final de WETH
        uint256 finalBalance = WETH.balanceOf(address(this));
        emit log_uint(finalBalance / 1e18);  // Dividimos por 1e18 para ver el valor en ETH
        assertEq(finalBalance, 1.2 ether);  // Verificamos que el balance final sea 1.2 ETH (0.2 inicial + 1 del depósito)
    }

    // Test para verificar la funcionalidad de DAI
    function testMintDai() public {
        // Creamos una dirección de prueba usando makeAddr llamada "alebeta"
        address alebeta = makeAddr("alebeta");
        
        // Verificamos el balance inicial de DAI y el total supply
        uint256 balance = DAI.balanceOf(alebeta);
        uint256 initialTotalSupply = DAI.totalSupply();

        emit log_uint(balance);
        emit log_uint(initialTotalSupply / 1e18);  // Mostramos el total supply en unidades de DAI

        // deal es una función de Foundry que nos permite dar tokens a una dirección
        // El último parámetro 'true' indica que queremos modificar el total supply
        deal(address(DAI), alebeta, 1 ether, true);

        // Verificamos los balances finales
        uint256 finalBalance = DAI.balanceOf(alebeta);
        uint256 finalTotalSupply = DAI.totalSupply();

        emit log_uint(finalBalance / 1e18);
        emit log_uint(finalTotalSupply / 1e18);
    }
}
//:~/tutorial_foundry$ forge test --match-path test/Forking.t.sol -vv --fork-url https://eth-mainnet.g.alchemy.com/v2/{ALCHEMY_API_KEY}