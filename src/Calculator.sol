// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity 0.8.24;

contract Calculator {
   
   // Variables
   uint256 public resultado;
   address public admin;

   // Events
   event Addition(uint256 num1_, uint256 num2_, uint256 resultado_);
   event Substraction(uint256 num1_, uint256 num2_, uint256 resultado_);
   event Multiplier(uint256 num1_, uint256 num2_, uint256 resultado_);
   event Division(uint256 num1_, uint256 num2_, uint256 resultado_);

   // Modifiers
   modifier onlyAdmin {
        require(msg.sender == admin, "Not allowed");
        _;
   }

   constructor(uint256 firstResultado_, address admin_){
    resultado = firstResultado_;
    admin = admin_;
   }
   // Functions
        // 1. Addition
    function addition(uint256 num1_, uint256 num2_) external returns(uint256 resultado_) {
        resultado_ = num1_ + num2_;
        resultado = resultado_;

        emit Addition(num1_, num2_, resultado_);
    }
        // 2. Substraction
    function substraction(uint256 num1_, uint256 num2_) external returns(uint256 resultado_) {
        resultado_ = num1_ - num2_;
        resultado = resultado_;

        emit Substraction(num1_, num2_, resultado_);
    }
        // 3. Multiplier
    function multiplier(uint256 num1_, uint256 num2_) external returns(uint256 resultado_) {
        resultado_ = num1_ * num2_;
        resultado = resultado_;

        emit Multiplier(num1_, num2_, resultado_);
    }
    
        // 4. Division

    function division(uint256 num1_, uint256 num2_) external onlyAdmin returns(uint256 resultado_) {
        if (num2_ == 0) return 0;
        resultado_ = num1_ / num2_;
        resultado = resultado_;

        emit Division(num1_, num2_, resultado_);
    }

}