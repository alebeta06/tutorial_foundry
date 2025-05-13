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
