//
//  CalculatorViewController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    enum Operations: String {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "x"
        case division = "÷"
        case delete = "DEL"
        case plusMinus = "+/-"
        case percent = "%"
        case equals = "="
        case decimal = "."
    }
    
    @IBOutlet weak var resultTextLabel: UILabel!
    var calculator: Calculator?
    var firstOperator = true
    var secondDeletePress = false
    var resultLabelValue: Double {
        let value = resultTextLabel.text ?? "0"
        return Double(value) ?? 0
    }
    
    var currentlyTypingNumber = CalculatorController.sharedController.currentlyTypingNumber
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func operationAction(_ sender: UIButton) {
        let title = sender.currentTitle
        let controller = CalculatorController.sharedController
        
        
        guard let currentTitle = title else { return }
        
        
        switch currentTitle {
        
        case Operations.delete.rawValue:
            
            if secondDeletePress {
                controller.saveToPersistentStorage()
                controller.delete()
                resultTextLabel.text = "0"
                controller.calculator.result = resultLabelValue
                currentlyTypingNumber = false
                secondDeletePress = false
            } else {
                resultTextLabel.text = "0"
                secondDeletePress = true
            }
        
        case Operations.plusMinus.rawValue:
            positiveOrNegative(currentNumber: resultLabelValue)
        
        case Operations.percent.rawValue:
            let percentValue = controller.percentage(currentNumber: resultLabelValue)
            resultTextLabel.text = removeTrailingZero(number: percentValue)
        
        case Operations.division.rawValue:
            controller.enter(addToStack: resultLabelValue)
            controller.enter(addToStack: "÷")
            currentlyTypingNumber = false
            
        case Operations.multiplication.rawValue:
            controller.enter(addToStack: resultLabelValue)
            controller.enter(addToStack: "*")
            currentlyTypingNumber = false
        
        case Operations.subtraction.rawValue:
            controller.enter(addToStack: resultLabelValue)
            controller.enter(addToStack: "-")
            currentlyTypingNumber = false
        
        case Operations.addition.rawValue:
            controller.enter(addToStack: resultLabelValue)
            controller.enter(addToStack: "+")
            currentlyTypingNumber = false
        
        case Operations.decimal.rawValue:
            convertToDecimalNumber(number: resultTextLabel.text!)
        
        case Operations.equals.rawValue:
            controller.enter(addToStack: resultLabelValue)
            let stack = CalculatorController.sharedController.calculator.operationStack
            let result = controller.runOperation(stackToUse: stack)
            controller.delete()
            controller.enter(addToStack: result)
            resultTextLabel.text = removeTrailingZero(number: result)
            currentlyTypingNumber = false
            firstOperator = true
        default:
            print("Error")
        }
    }
    
    @IBAction func buttonNumberInput(_ sender: UIButton) {
        
        let resultLabelText = resultTextLabel.text!
        let buttonNumber = sender.currentTitle ?? ""
        
        if currentlyTypingNumber {
            resultTextLabel.text = resultLabelText + buttonNumber
            
        } else {
            resultTextLabel.text = buttonNumber
            currentlyTypingNumber = true
        }
    }
    
    @IBAction func newTabButtonTapped(_ sender: UIBarButtonItem) {
        
        let calculator = Calculator(result: resultLabelValue, operationStack: CalculatorController.sharedController.calculator.operationStack, currentlyTypingNumber: currentlyTypingNumber)
        CalculatorController.sharedController.saveCalculatorTab(calculatorTab: calculator)
        CalculatorController.sharedController.delete()
    }
    
    
    
    func convertToDecimalNumber(number: String) {
        let decimalNumber = number + "."
        resultTextLabel.text = decimalNumber
    }
    
    func positiveOrNegative(currentNumber: Double) {
        
            var resultValue = currentNumber
            resultValue = resultValue * -1
            resultTextLabel.text = removeTrailingZero(number: resultValue)
            currentlyTypingNumber = false
    }
    
    func removeTrailingZero(number: Double) -> String {
        let tempNumber = String(format: "%g", number)
        return tempNumber
    }
    
    
}
