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
    var secondDeletePress = false
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
            
            if secondDeletePress {
                NumberController.sharedController.delete()
                resultTextLabel.text = "0"
                NumberController.sharedController.number.resultNumber = resultLabelValue
                currentlyTypingNumber = false
                secondDeletePress = false
            } else {
                resultTextLabel.text = "0"
                secondDeletePress = true
            }
        
        case Operations.plusMinus.rawValue:
            positiveOrNegative(currentNumber: resultLabelValue)
        
        case Operations.percent.rawValue:
            let percentValue = NumberController.sharedController.percentage(currentNumber: resultLabelValue)
            resultTextLabel.text = removeTrailingZero(number: percentValue)
        
        case Operations.division.rawValue:
            NumberController.sharedController.enter(addToStack: resultLabelValue)
            NumberController.sharedController.enter(addToStack: "÷")
            currentlyTypingNumber = false
            
        case Operations.multiplication.rawValue:
            NumberController.sharedController.enter(addToStack: resultLabelValue)
            NumberController.sharedController.enter(addToStack: "*")
            currentlyTypingNumber = false
        
        case Operations.subtraction.rawValue:
            NumberController.sharedController.enter(addToStack: resultLabelValue)
            NumberController.sharedController.enter(addToStack: "-")
            currentlyTypingNumber = false
        
        case Operations.addition.rawValue:
            NumberController.sharedController.enter(addToStack: resultLabelValue)
            NumberController.sharedController.enter(addToStack: "+")
            currentlyTypingNumber = false
        
        case Operations.decimal.rawValue:
            convertToDecimalNumber(number: resultTextLabel.text!)
        
        case Operations.equals.rawValue:
            NumberController.sharedController.enter(addToStack: resultLabelValue)
            resultTextLabel.text = removeTrailingZero(number: NumberController.sharedController.runOperation(stackToUse: NumberController.sharedController.stack))
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
