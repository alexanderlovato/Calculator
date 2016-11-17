//
//  CalculatorViewController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, DestinationViewControllerDelegate {
    
    enum Operations: String {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "x"
        case division = "÷"
        case delete = "C"
        case plusMinus = "+/-"
        case percent = "%"
        case equals = "="
        case decimal = "."
    }
    
    
    @IBOutlet weak var wallpaperImageView: UIImageView!
    @IBOutlet weak var resultTextLabel: UILabel!
    let sharedController = CalculatorController.sharedController
    var firstOperator = true
    var resultLabelValue: Double {
        let value = resultTextLabel.text ?? "0"
        return Double(value) ?? 0
    }
    
    var currentlyTypingNumber = CalculatorController.sharedController.currentlyTypingNumber
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
//        blurredEffectView.frame = wallpaperImageView!.bounds
//        view.insertSubview(blurredEffectView, aboveSubview: wallpaperImageView)
        
    }
    
    @IBAction func operationAction(_ sender: UIButton) {
        let title = sender.currentTitle
        
        guard let currentTitle = title else { return }
        
        
        switch currentTitle {
        
        case Operations.delete.rawValue:

                let calculator = Calculator(result: resultLabelValue, operationStack: sharedController.calculator.operationStack, currentlyTypingNumber: currentlyTypingNumber)
                if sharedController.calculator.operationStack.count > 0 {
                    sharedController.saveCalculatorTab(calculatorTab: calculator)
                }
                sharedController.delete()
                resultTextLabel.text = "0"
                sharedController.calculator.result = resultLabelValue
                currentlyTypingNumber = false
        
        case Operations.plusMinus.rawValue:
            positiveOrNegative(currentNumber: resultLabelValue)
        
        case Operations.percent.rawValue:
            let percentValue = sharedController.percentage(currentNumber: resultLabelValue)
            resultTextLabel.text = removeTrailingZero(number: percentValue)
        
        case Operations.division.rawValue:
            sharedController.enter(addToStack: resultLabelValue)
            sharedController.enter(addToStack: "÷")
            currentlyTypingNumber = false
            
        case Operations.multiplication.rawValue:
            sharedController.enter(addToStack: resultLabelValue)
            sharedController.enter(addToStack: "x")
            currentlyTypingNumber = false
        
        case Operations.subtraction.rawValue:
            sharedController.enter(addToStack: resultLabelValue)
            sharedController.enter(addToStack: "-")
            currentlyTypingNumber = false
        
        case Operations.addition.rawValue:
            sharedController.enter(addToStack: resultLabelValue)
            sharedController.enter(addToStack: "+")
            currentlyTypingNumber = false
        
        case Operations.decimal.rawValue:
            convertToDecimalNumber(number: resultTextLabel.text!)
        
        case Operations.equals.rawValue:
            sharedController.enter(addToStack: resultLabelValue)
            let stack = sharedController.calculator.operationStack
            let result = sharedController.runOperation(stackToUse: stack)
            sharedController.delete()
            sharedController.enter(addToStack: result)
            resultTextLabel.text = removeTrailingZero(number: result)
            currentlyTypingNumber = false
            firstOperator = true
        default:
            print("Error")
        }
    }
    
    @IBAction func backspaceButtonTapped(_ sender: UIButton) {
        
        if resultTextLabel.text == "" {
            resultTextLabel.text = "0"
            currentlyTypingNumber = false
        } else {
            guard let resultText = resultTextLabel.text else { return }
            let truncated = resultText.substring(to: resultText.index(before: resultText.endIndex))
            resultTextLabel.text! = truncated
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
    
    @IBAction func newTabButtonTapped(_ sender: UIButton) {
        
        let stack = sharedController.calculator.operationStack
        
        if currentlyTypingNumber || stack.count == 0 {
            var currentStack = sharedController.calculator.operationStack
            currentStack.append(resultLabelValue)
            let calculator = Calculator(result: resultLabelValue, operationStack: currentStack, currentlyTypingNumber: currentlyTypingNumber)
            sharedController.saveCalculatorTab(calculatorTab: calculator)
        } else {
            
            let calculator = Calculator(result: resultLabelValue, operationStack: sharedController.calculator.operationStack, currentlyTypingNumber: currentlyTypingNumber)
            sharedController.saveCalculatorTab(calculatorTab: calculator)
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
    
    func passNumberBack(data: [Any]) {
        let lastObject = "\(data.last!)"
        var dataStack = data
        
        switch lastObject {
            
        //Check if the last object from the selected History table is an operator
        case "+", "-", "x", "÷":
            let currentStack = sharedController.calculator.operationStack.last as? String ?? ""
            
            //Then check if the last object of the operationStack is an operator
            if currentStack == "+" || currentStack == "-" || currentStack == "x" || currentStack == "÷" {
                sharedController.mergeStacks(addToStack: data)
                currentlyTypingNumber = false
                resultTextLabel.text = "0"
            } else if sharedController.calculator.operationStack.count == 0 {
                
                //Since neither stacks end with an operator: Remove last number from selected histroy stack, merge that stack with the operatorStack, then set the resultTextLabel to the last removed object of history stack
                sharedController.mergeStacks(addToStack: dataStack)
                resultTextLabel.text = "0"
                currentlyTypingNumber = false
            } else {
                sharedController.enter(addToStack: resultLabelValue)
                resultTextLabel.text = "0"
                currentlyTypingNumber = false
                sharedController.mergeStacks(addToStack: dataStack)
                
            }
            
        default:
            if data.count > 2 {
                let labelNumber = removeTrailingZero(number: dataStack.removeLast() as! Double)
                sharedController.mergeStacks(addToStack: dataStack)
                resultTextLabel.text = labelNumber
                currentlyTypingNumber = true
            } else {
                //If none of the above scenarios match then execute this block of code
                let labelNumber = removeTrailingZero(number: dataStack.removeLast() as! Double)
                resultTextLabel.text = labelNumber
                currentlyTypingNumber = true
            
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHistoryTable" {
            let navigation = segue.destination as! UINavigationController
            let destinationViewController = navigation.topViewController as! CalculationHistoryViewController
            destinationViewController.delegate = self
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        }
    }

}
