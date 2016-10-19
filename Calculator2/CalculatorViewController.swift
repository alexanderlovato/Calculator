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
    var firstOperator = true
    var firstOperatorString = String()
    
    var resultLabelValue: Double {
        let value = resultTextLabel.text ?? "0"
        return Double(value) ?? 0
    }
    
    var currentlyTypingNumber = NumberController.sharedController.currentlyTypingNumber
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func operationAction(_ sender: UIButton) {
        let title = sender.currentTitle
        
        guard let currentTitle = title else { return }
        
        switch currentTitle {
        
        case Operations.delete.rawValue:
            NumberController.sharedController.number.operation = ""
            NumberController.sharedController.delete()
            resultTextLabel.text = "0"
            NumberController.sharedController.number.resultNumber = resultLabelValue
            currentlyTypingNumber = false
        
        case Operations.plusMinus.rawValue:
            positiveOrNegative(currentNumber: resultLabelValue)
        
        case Operations.percent.rawValue:
            let percentValue = NumberController.sharedController.percentage(currentNumber: resultLabelValue)
            resultTextLabel.text = removeTrailingZero(number: percentValue)
        
        case Operations.division.rawValue:
            doNumberStuff(operation: "÷")
        
        case Operations.multiplication.rawValue:
            doNumberStuff(operation: "x")
        
        case Operations.subtraction.rawValue:
            doNumberStuff(operation: "-")
        
        case Operations.addition.rawValue:
            doNumberStuff(operation: "+")
        
        case Operations.decimal.rawValue:
            convertToDecimalNumber(number: resultTextLabel.text!)
        
        case Operations.equals.rawValue:
            NumberController.sharedController.enter(currentNumber: resultLabelValue)
            NumberController.sharedController.setOperator(operatorString: NumberController.sharedController.number.operation)
            resultTextLabel.text = removeTrailingZero(number: NumberController.sharedController.number.resultNumber)
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
    
    func doNumberStuff(operation: String) {
        
        if firstOperator {
            firstOperatorString = operation
            NumberController.sharedController.number.operation = operation
            NumberController.sharedController.enter(currentNumber: resultLabelValue)
            currentlyTypingNumber = false
            firstOperator = false
        } else {
            NumberController.sharedController.enter(currentNumber: resultLabelValue)
            NumberController.sharedController.setOperator(operatorString: firstOperatorString)
            currentlyTypingNumber = false
            NumberController.sharedController.number.operation = operation
            NumberController.sharedController.enter(currentNumber: NumberController.sharedController.number.resultNumber)
        }
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
