# 🏗️ Foundry Learning Journey

![Foundry Logo](https://github.com/user-attachments/assets/5b69591c-1553-49f6-b0ed-27e35bac3cd1)

## 📚 Introducción a Foundry

Foundry es un conjunto de herramientas moderno y potente para el desarrollo de smart contracts en Ethereum, escrito en Rust. Este repositorio documenta mi aprendizaje y práctica con Foundry, incluyendo ejemplos prácticos y explicaciones detalladas.

### 🛠️ Componentes Principales

- **Forge**: Framework de testing para Ethereum (similar a Truffle/Hardhat)
- **Cast**: Herramienta CLI para interactuar con contratos EVM
- **Anvil**: Nodo local de Ethereum (similar a Ganache)
- **Chisel**: REPL interactivo para Solidity

## 🎯 Proyectos y Ejemplos

Este repositorio contiene varios ejemplos prácticos que demuestran diferentes aspectos del desarrollo con Foundry:

### 1. Contratos Básicos

- `Counter.sol` & `Counter.t.sol`: Implementación y testing de un contador simple
- `HolaMundo.sol` & `HolaMundo.t.sol`: Primer contrato y sus tests

### 2. Testing Avanzado

- `InvariantExample1.t.sol`: Demostración de testing invariante
- `Forking.t.sol`: Ejemplos de testing con forking de mainnet
- `OwnerUpOnly.sol` & `OwnerUpOnly.t.sol`: Testing de control de acceso

### 3. Patrones de Diseño

- `Factory.sol` & `Factory.t.sol`: Implementación del patrón Factory
- `University.sol` & `University.t.sol`: Ejemplo de interacción entre contratos

### 4. Seguridad y Verificación

- `SigningExample.sol` & `SigningExample.t.sol`: Verificación de firmas
- `Safe.sol` & `Safe.t.sol`: Ejemplos de seguridad en contratos

### 5. Eventos y Logging

- `EmitContract.sol` & `EmitContract.t.sol`: Testing de eventos

## 🚀 Comandos Foundry

### Desarrollo y Testing

```bash
# Compilar contratos
forge build

# Ejecutar todos los tests
forge test

# Ejecutar tests específicos
forge test --match-contract CounterTest
forge test --match-test testIncrement

# Ejecutar tests con más verbosidad
forge test -vvv

# Ejecutar tests con gas reporting
forge test --gas-report

# Ejecutar tests específicos por ruta
forge test --match-path test/Counter.t.sol
```

### Análisis de Gas

```bash
# Generar snapshot de gas
forge snapshot

# Comparar con snapshot anterior
forge snapshot --diff

# Análisis detallado de gas
# Ver reporte de gas para todos los tests
forge test --gas-report

# Ver reporte de gas para un contrato específico
forge test --match-contract ContractName --gas-report

# Ver reporte de gas para una función específica
forge test --match-test testFunctionName --gas-report

# Ver gas usado en una función específica con trazas
forge test --match-test testFunctionName -vvvv

# Ver gas usado en todas las funciones de un contrato
forge test --match-contract ContractName -vvvv

# Generar reporte de gas en formato JSON
forge test --gas-report --json > gas-report.json

# Ver gas usado en una transacción específica
forge test --match-test testFunctionName --trace-gas
```

### Ejemplo de Reporte de Gas

El reporte de gas muestra información detallada sobre el consumo de gas:

```
| Contract           | Method        | Min     | Max     | Avg     | # calls |
|--------------------|---------------|---------|---------|---------|---------|
| Counter            | increment     | 28347   | 28347   | 28347   | 1       |
| Counter            | count         | 2214    | 2214    | 2214    | 2       |
```

### Tips para Análisis de Gas

- Usar `--gas-report` para obtener una visión general del consumo
- Combinar con `-vvvv` para ver trazas detalladas con gas
- Comparar diferentes implementaciones con `forge snapshot --diff`
- Usar `--trace-gas` para análisis profundo de transacciones específicas
- Exportar a JSON para análisis posterior o comparativas

### Desarrollo Local

```bash
# Iniciar nodo local (Anvil)
anvil

# Desplegar contrato
forge create Contract --private-key <PRIVATE_KEY>
forge create Contract --interactive

# Script de deployment
forge script script/Deploy.s.sol --rpc-url <RPC_URL> --private-key <PRIVATE_KEY>
```

### Interacción con Contratos (Cast)

```bash
# Llamar a función de contrato
cast call <CONTRACT_ADDRESS> "functionName()"

# Enviar transacción
cast send <CONTRACT_ADDRESS> "functionName()" --private-key <PRIVATE_KEY>

# Obtener balance
cast balance <ADDRESS>
```

## 📝 Tips y Mejores Prácticas

1. **Testing Eficiente**

   - Usar `forge test -vvv` para debugging detallado
   - Implementar fuzzing tests para mayor cobertura
   - Utilizar invariantes para testing de propiedades
   - Entender las trazas de los tests:
     - `forge test -vvv`: Muestra trazas para tests fallidos
     - `forge test -vvvv`: Muestra trazas para todos los tests
     - Formato de trazas:
       ```
       [<Gas Usage>] <Contract>::<Function>(<Parameters>)
         ├─ [<Gas Usage>] <Contract>::<Function>(<Parameters>)
         │   └─ ← <Return Value>
         └─ ← <Return Value>
       ```
     - Colores en las trazas:
       - Verde: Llamadas exitosas
       - Rojo: Llamadas revertidas
       - Azul: Llamadas a códigos de trucos
       - Cian: Registros emitidos
       - Amarillo: Implementaciones de contratos
     - El gas mostrado incluye operaciones entre llamadas (aritmética, lecturas/escrituras)

2. **Gas Optimization**

   - Revisar reportes de gas regularmente
   - Comparar optimizaciones con `forge snapshot --diff`
   - Usar `forge test --gas-report` para análisis detallado

3. **Debugging**
   - Usar `console.log()` para debugging
   - Implementar `vm.trace()` para seguimiento de transacciones
   - Utilizar `forge test --debug` para debugging interactivo

## 🔧 Cheatcodes de Foundry

Foundry proporciona un conjunto de cheatcodes que permiten manipular el estado de la blockchain y facilitar el testing. Aquí están los más comunes:

### Manipulación de Estado

| Cheatcode                            | Descripción                             | Ejemplo                                 |
| ------------------------------------ | --------------------------------------- | --------------------------------------- |
| `vm.warp(uint256)`                   | Cambia el timestamp del bloque          | `vm.warp(100)`                          |
| `vm.roll(uint256)`                   | Cambia el número de bloque              | `vm.roll(1000)`                         |
| `vm.deal(address, uint256)`          | Establece el balance de ETH             | `vm.deal(address, 1 ether)`             |
| `vm.startPrank(address)`             | Cambia el msg.sender                    | `vm.startPrank(alice)`                  |
| `vm.stopPrank()`                     | Restaura el msg.sender original         | `vm.stopPrank()`                        |
| `vm.prank(address)`                  | Cambia msg.sender para una sola llamada | `vm.prank(alice)`                       |
| `vm.mockCall(address, bytes, bytes)` | Mockea una llamada a contrato           | `vm.mockCall(target, data, returnData)` |

### Manipulación de Tokens

| Cheatcode                                         | Descripción                | Ejemplo                                |
| ------------------------------------------------- | -------------------------- | -------------------------------------- |
| `deal(address, address, uint256)`                 | Establece balance de ERC20 | `deal(token, user, 1000e18)`           |
| `dealERC721(address, address, uint256)`           | Transfiere NFT             | `dealERC721(nft, user, tokenId)`       |
| `dealERC1155(address, address, uint256, uint256)` | Establece balance ERC1155  | `dealERC1155(token, user, id, amount)` |

### Testing y Aserciones

| Cheatcode                       | Descripción                              | Ejemplo                       |
| ------------------------------- | ---------------------------------------- | ----------------------------- |
| `vm.expectRevert()`             | Espera que la siguiente llamada revierta | `vm.expectRevert()`           |
| `vm.expectRevert(bytes)`        | Espera revert con mensaje específico     | `vm.expectRevert("Error")`    |
| `vm.assume(bool)`               | Filtra casos en fuzzing                  | `vm.assume(amount > 0)`       |
| `vm.expectCall(address, bytes)` | Verifica llamada a contrato              | `vm.expectCall(target, data)` |

### Forking y Snapshots

| Cheatcode                              | Descripción               | Ejemplo                                    |
| -------------------------------------- | ------------------------- | ------------------------------------------ |
| `vm.createSelectFork(string)`          | Crea fork de una red      | `vm.createSelectFork("mainnet")`           |
| `vm.createSelectFork(string, uint256)` | Fork en bloque específico | `vm.createSelectFork("mainnet", 12345678)` |
| `vm.snapshot()`                        | Crea snapshot del estado  | `uint256 id = vm.snapshot()`               |
| `vm.revertTo(uint256)`                 | Revierte a snapshot       | `vm.revertTo(id)`                          |

### Ejemplos de Uso

```solidity
// Cambiar timestamp y número de bloque
vm.warp(block.timestamp + 1 days);
vm.roll(block.number + 1);

// Manipular balances y cuentas
vm.deal(address(this), 1 ether);
vm.startPrank(alice);
contract.function();
vm.stopPrank();

// Mockear llamadas
vm.mockCall(
    address(token),
    abi.encodeWithSelector(IERC20.balanceOf.selector, address(this)),
    abi.encode(1000e18)
);

// Testing de revert
vm.expectRevert("Insufficient balance");
contract.transfer(address(0), 1000e18);

// Forking
vm.createSelectFork("mainnet", 12345678);
```

### Tips para Uso de Cheatcodes

1. **Organización**

   - Usar `setUp()` para configuración común
   - Agrupar cheatcodes relacionados
   - Documentar casos de uso complejos

2. **Buenas Prácticas**

   - Limpiar estado después de cada test
   - Usar `vm.stopPrank()` después de `startPrank()`
   - Verificar aserciones después de manipular estado

3. **Debugging**
   - Usar `-vvv` para ver trazas detalladas
   - Combinar con `console.log()` para debugging
   - Verificar estado antes y después de operaciones

## 💰 Configuración de Wallets en Foundry

Foundry permite gestionar múltiples wallets para testing y deployment. Aquí te explico cómo configurarlas y usarlas:

### 1. **Wallets Actuales**

Para ver las wallets configuradas:

```bash
cast wallet list
```

### 2. **Ubicación y Alcance de las Wallets**

✅ **Dónde se guardan las wallets:**

- Las wallets se guardan en tu directorio home (`~/.foundry/` o similar)
- Son **globales** para todo tu sistema
- Puedes usarlas desde cualquier proyecto de Foundry

✅ **Dónde ejecutar los comandos:**

- Puedes ejecutar `cast wallet` desde **cualquier directorio**
- No necesitas estar fuera de `~/tutorial_foundry`
- Puedes ejecutarlos desde dentro del proyecto

### 3. **Pasos para Configurar Wallets con Private Keys**

#### Opción A: Usando `cast wallet import`

```bash
# Importar wallet con private key
cast wallet import <WALLET_NAME> --private-key <PRIVATE_KEY>

# Ejemplo:
cast wallet import deployer --private-key 0x1234567890abcdef...
```

#### Opción B: Usando `cast wallet new`

```bash
# Crear nueva wallet (genera nueva private key)
# Nota: En algunas versiones, el nombre debe ser un directorio
mkdir my-wallet
cast wallet new my-wallet

# O usar un nombre sin guiones
cast wallet new mywallet
```

#### Opción C: Usando `cast wallet import` con mnemónica

```bash
# Importar desde mnemónica
cast wallet import <WALLET_NAME> --mnemonic "word1 word2 word3..."

# Ejemplo:
cast wallet import test-wallet --mnemonic "test test test test test test test test test test test junk"
```

### 4. **Comandos Útiles para Gestión de Wallets**

```bash
# Listar todas las wallets
cast wallet list

# Ver detalles de una wallet específica
cast wallet show <WALLET_NAME>

# Eliminar una wallet
cast wallet remove <WALLET_NAME>

# Cambiar wallet por defecto
cast wallet default <WALLET_NAME>
```

### 5. **Usar Wallets en Comandos**

```bash
# Usar wallet específica en comando
cast send <CONTRACT_ADDRESS> "function()" --wallet <WALLET_NAME>

# Ejemplo:
cast send 0x123... "increment()" --wallet deployer

# Usar wallet por defecto
cast send <CONTRACT_ADDRESS> "function()"
```

### 6. **Ejemplo Completo de Configuración**

```bash
# 1. Crear wallet nueva (opción 1: crear directorio)
mkdir my-wallet
cast wallet new my-wallet

# O crear wallet nueva (opción 2: nombre simple)
cast wallet new mywallet

# 2. Ver la wallet creada
cast wallet show mywallet

# 3. Usar la wallet
cast send <CONTRACT> "function()" --wallet mywallet

# 4. Verificar balance
cast balance <ADDRESS> --wallet mywallet
```

### 7. **Configuración de Wallet para Despliegues (scaffold-eth-default)**

Este proyecto incluye una configuración específica para la wallet `scaffold-eth-default` que se usa para despliegues automáticos:

#### 🔑 Cómo se creó y configuró la Private Key

**1. Se generó e importó una cuenta con `cast wallet import`**

```bash
cast wallet import --private-key 0xTU_CLAVE_PRIVADA --unsafe-password 'localhost' scaffold-eth-default
```

**Qué hace este comando:**

- Importa la private key para pruebas o despliegues locales
- Crea un keystore cifrado usando la contraseña 'localhost'
- Asigna el alias `scaffold-eth-default` a esa wallet

🔐 **Nota:** `--unsafe-password` solo debe usarse en entornos de desarrollo. ¡Nunca en producción!

**2. Se almacenó en:**

```bash
~/.foundry/keystores/scaffold-eth-default
```

Este archivo contiene la clave privada cifrada.

**3. Se configuró para ser usada en los despliegues de forge**
Gracias al Makefile personalizado, se añadieron condiciones para detectar si se usaba el keystore `scaffold-eth-default`. Esto permitió ejecutar despliegues con:

```bash
make deploy
```

Y automáticamente se usó la wallet importada con:

```bash
forge script script/Deploy.s.sol \
  --rpc-url <tu_rpc> \
  --broadcast \
  --password localhost \
  --legacy \
  --ffi
```

**4. Se integró en el Makefile**
La sección `setup-anvil-wallet` del Makefile se encargaba de crear todo esto automáticamente:

```makefile
setup-anvil-wallet:
	shx rm ~/.foundry/keystores/scaffold-eth-default 2>/dev/null; \
	shx rm -rf broadcast/Deploy.s.sol/31337
	cast wallet import --private-key 0x2a871d... --unsafe-password 'localhost' scaffold-eth-default
```

#### 🧪 Verificar que está funcionando

Para confirmar que la wallet fue correctamente importada y está lista para usarse:

```bash
cast wallet address --account scaffold-eth-default
```

## 🔗 Recursos Adicionales

- [Documentación Oficial de Foundry](https://book.getfoundry.sh/)
- [Cheatsheet de Forge](https://book.getfoundry.sh/cheatcodes/)
- [Ejemplos de Testing](https://book.getfoundry.sh/tutorials/best-practices)

## 📊 Estado del Proyecto

Este repositorio está en constante evolución mientras continúo aprendiendo y practicando con Foundry. Los ejemplos y documentación se actualizarán regularmente con nuevos conceptos y mejores prácticas.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue o pull request para sugerir mejoras o correcciones.

## 📄 Licencia

MIT
