// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity 0.8.24;

import "../src/Calculator.sol";
import "forge-std/Test.sol";

contract CalculatorTest is Test {
    
    Calculator calculator;
    uint256 public firstResult = 100;
    address public admin = vm.addr(1);
    address public randomUser = vm.addr(2);
    uint256 num1_ = 5;
    uint256 num2_ = 3;

    function setUp() public {
        calculator = new Calculator(firstResult, admin);
    }

    // Unit testing - Given inputs
    function testCheckFirstResult() public view {
        assert(calculator.resultado() == firstResult);
    }

    function testAddition() public {        
        assert(calculator.addition(num1_, num2_) == num1_ + num2_);        
    }

    function testSubstraction() public {        
        assert(calculator.substraction(num1_, num2_) == num1_ - num2_);        
    }

    function testMultiplier() public {      
        assert(calculator.multiplier(num1_, num2_) == num1_ * num2_);        
    }

    function testCannotMultiply2LargeNumbers() public {
        uint256 large1_ = 5;
        uint256 large2_ = 2**256 - 2;

        vm.expectRevert();
        calculator.multiplier(large1_, large2_);        
    }

    function testWhenNotAdminDivision() public {
        vm.startPrank(randomUser);

        vm.expectRevert();
        calculator.division(num1_, num2_);

        vm.stopPrank();
    }

    function testWhenAdminDivision() public {
        vm.startPrank(admin);

        assert(calculator.division(num1_, num2_) == num1_ / num2_);

        vm.stopPrank();
    }

    function testWhenNoPrankDivision() public {
        vm.expectRevert();
        console.log(msg.sender);
        calculator.division(num1_, num2_);
    }  

    // Fuzzing testing (Advanced) - Random inputs

    function testFuzzingDivision(uint256 firstNum_, uint256 secondNum_) public {
        vm.startPrank(admin);

        calculator.division(firstNum_, secondNum_);

        vm.stopPrank();
    }

}

