# 🧮 Calculator – A Foundry-Powered Arithmetic Contract in Solidity

![Solidity](https://img.shields.io/badge/Solidity-0.8.24-blue?style=flat&logo=solidity)
![License](https://img.shields.io/badge/License-LGPL--3.0--only-green?style=flat)
![Framework](https://img.shields.io/badge/Tested%20with-Foundry-orange)

## 📌 Description

This project demonstrates a simple yet structured arithmetic contract written in Solidity and tested using the **Foundry** framework.

- **`Calculator.sol`**: A stateful calculator supporting basic operations (`+`, `-`, `×`, `/`) with admin-restricted division.
- **`CalculatorTest.t.sol`**: Unit and fuzz tests for arithmetic correctness, access control, and edge cases using Foundry's `forge-std`.

This project serves as a clean, minimal entry point for writing, testing, and reasoning about smart contract behavior.

---

## 📁 Project Structure

```
├── src/
│   └── Calculator.sol        # Arithmetic logic contract
├── test/
│   └── CalculatorTest.t.sol  # Foundry test suite for Calculator
```

---

## 🧱 Components

### `Calculator.sol`

- Stores the last computed result (`resultado`)
- Basic arithmetic operations (`+`, `-`, `×`, `/`)
- Admin-protected division logic
- Emits events for each operation

```solidity
constructor(uint256 firstResultado_, address admin_) {
    resultado = firstResultado_;
    admin = admin_;
}
```

Division is restricted:

```solidity
function division(uint256 num1_, uint256 num2_) external onlyAdmin returns (uint256 resultado_) {
    if (num2_ == 0) return 0;
    resultado_ = num1_ / num2_;
    resultado = resultado_;
    emit Division(num1_, num2_, resultado_);
}
```

---

### `CalculatorTest.t.sol`

A robust test suite using [Foundry](https://book.getfoundry.sh/):

- ✅ Unit tests for each operation
- 🔒 Admin restriction on division
- 💥 Expectation for overflow and unauthorized access
- 🎲 Fuzzing test for randomized division inputs

Sample test:

```solidity
function testAddition() public {
    assert(calculator.addition(num1_, num2_) == num1_ + num2_);
}
```

Admin check:

```solidity
function testWhenNotAdminDivision() public {
    vm.startPrank(randomUser);
    vm.expectRevert();
    calculator.division(num1_, num2_);
    vm.stopPrank();
}
```

---

## 🧪 Running Tests

Ensure you have [Foundry installed](https://book.getfoundry.sh/getting-started/installation):

```bash
forge test
```

You can also run with fuzzing enabled:

```bash
forge test --fuzz
```

---

## 📄 License

This project is licensed under the **GNU Lesser General Public License v3.0-only** – see the [`LICENSE`](./LICENSE) file.

---

## 📬 Contact

Feel free to open an issue or PR to suggest improvements, add edge cases, or expand functionality (e.g., exponentiation, mod, etc).
