//
//  CalculatorViewController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, DestinationViewControllerDelegate {
    
    // MARK: - Enumerators
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
    
    // MARK: - Outlets
    @IBOutlet weak var wallpaperImageView: UIImageView!
    @IBOutlet weak var resultTextLabel: UILabel!
    
    // MARK: - Shared Controller
    let sharedController = CalculatorController.sharedController
    
    // MARK: - Properties
    var finishedEquation = false
    
    // Returns current result as a Double
    var resultLabelValue: Double {
        let value = resultTextLabel.text ?? "0"
        let returnValue = ScoreFormatter.unformattedNumber(value)
        guard let returnDouble = returnValue else { return 0 }
        return Double(returnDouble)
    }
    
    // Take and return screenshot of current view
    var snapshotImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, 0)
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshot ?? UIImage()
    }
    
    // MARK: - Calculator singleton
    var calculator = CalculatorController.sharedController.calculators.last ?? Calculator(currentNumber: "0", operationStack: [], entireOperationString: [], currentlyTypingNumber: false, screenshotData: Data())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if sharedController.calculators.count == 0 {
            sharedController.saveCalculatorTab(calculatorTab: calculator)
        }
        
        // Formats current result to use decimals
        resultTextLabel.text = ScoreFormatter.formattedScore(calculator.currentNumber)
        
        // Adds blur effect to the background image
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = wallpaperImageView!.bounds
        view.insertSubview(blurredEffectView, aboveSubview: wallpaperImageView)
    }
    
    // MARK: - View Controller Actions
    
    // Stores current result, snaps a screenshot of the current calculator, then transitions back to CardCollectionViewController
    @IBAction func multitaskingButton(_ sender: UIBarButtonItem) {
        calculator.currentNumber = resultTextLabel.text!
        calculator.screenshotImage = snapshotImage
        sharedController.saveToPersistentStorage()
        _ = navigationController?.popViewController(animated: true)
    }
    
    // Action called when any of the operator buttons are tapped
    @IBAction func operationAction(_ sender: UIButton) {
        let title = sender.currentTitle
        guard let currentTitle = title else { return }
        
        switch currentTitle {
        
        // Delete button (C)
        case Operations.delete.rawValue:
            calculator.delete()
            resultTextLabel.text = "0"
            calculator.currentNumber = "0"
            calculator.currentlyTypingNumber = false
            finishedEquation = false
            
        // Positive or Negative button (+/-)
        case Operations.plusMinus.rawValue:
            resultTextLabel.text = positiveOrNegative(currentNumber: resultLabelValue)
            
        // Percent button (%)
        case Operations.percent.rawValue:
            let percentValue = percentage(currentNumber: resultLabelValue)
            let removedZero = removeTrailingZero(number: percentValue)
            resultTextLabel.text = ScoreFormatter.formattedScore(removedZero)
            calculator.currentNumber = ScoreFormatter.unformattedNumberString(resultTextLabel.text ?? "0") ?? "0"
            
        // Division button (÷)
        case Operations.division.rawValue:
            calculator.enter(addToStack: resultLabelValue)
            calculator.enter(addToStack: "÷")
            calculator.currentlyTypingNumber = false
            finishedEquation = false
            
        // Multiplication button (x)
        case Operations.multiplication.rawValue:
            calculator.enter(addToStack: resultLabelValue)
            calculator.enter(addToStack: "x")
            calculator.currentlyTypingNumber = false
            finishedEquation = false
            
        // Subtraction button (-)
        case Operations.subtraction.rawValue:
            calculator.enter(addToStack: resultLabelValue)
            calculator.enter(addToStack: "-")
            calculator.currentlyTypingNumber = false
            finishedEquation = false
            
        // Addition button (+)
        case Operations.addition.rawValue:
            calculator.enter(addToStack: resultLabelValue)
            calculator.enter(addToStack: "+")
            calculator.currentlyTypingNumber = false
            finishedEquation = false
            
        // Decimal button (.)
        case Operations.decimal.rawValue:
            resultTextLabel.text = convertToDecimalNumber(number: resultTextLabel.text ?? "0")
            sharedController.saveToPersistentStorage()
            calculator.currentlyTypingNumber = true
        
        // Equals button (=)
        case Operations.equals.rawValue:
            calculator.enter(addToStack: resultLabelValue)
            
            // Get the operation stack and put it in "stack"
            let stack = calculator.operationStack
            
            // Call runOperation to get the sum of "stack", then store the sum in "result"
            let result = runOperation(stackToUse: stack)
            
            // Now that we have the sum of the operationStack in "result", clear the operationStack
            calculator.delete()
            
            // Check in case the equation has not finished
            if finishedEquation == false {
                calculator.enter(addToStack: result)
                let stackString = calculator.operationStack.map{ String(describing: $0) }.joined(separator: " ")
                let entry = History(historyStack: stackString)
                sharedController.saveHistortyEntry(historyEntry: entry)
                calculator.delete()
            }
            
            // Format the number to not show a ".0" at the end
            // Format the number to show a comma for every third number
            let labelResult = removeTrailingZero(number: result)
            resultTextLabel.text = ScoreFormatter.formattedScore(labelResult)
            calculator.currentNumber = labelResult
            sharedController.saveToPersistentStorage()
            calculator.currentlyTypingNumber = false
            finishedEquation = true
        
        default:
            print("Error in handling calculator operators")
        }
        sharedController.saveToPersistentStorage()
    }
    
    // Enables backspace functionality
    @IBAction func backspaceButtonTapped(_ sender: UIButton) {
        
        if resultTextLabel.text == "" {
            resultTextLabel.text = "0"
            calculator.currentNumber = "0"
            calculator.currentlyTypingNumber = false
        } else {
            let resultText = resultTextLabel.text ?? "0"
            let truncated = resultText.substring(to: resultText.index(before: resultText.endIndex))
            resultTextLabel.text! = ScoreFormatter.formattedScore(truncated) ?? "0"
            calculator.currentNumber = truncated
        }
        sharedController.saveToPersistentStorage()
    }
    
    //Action for all input from the number pad
    @IBAction func buttonNumberInput(_ sender: UIButton) {
        let buttonNumber = sender.titleLabel?.text ?? "0"
        let unformattedNumber = ScoreFormatter.unformattedNumberString(resultTextLabel.text ?? "0") ?? "0"
        let labelNumber = resultTextLabel.text ?? "0"
        
        if calculator.currentlyTypingNumber {
            if resultTextLabel.text?.contains(find: ".") == true {
                let number = labelNumber + buttonNumber
                resultTextLabel.text = number
                calculator.currentNumber = number
            } else {
                let formattedNumber = unformattedNumber + buttonNumber
                resultTextLabel.text = ScoreFormatter.formattedScore(formattedNumber)
                calculator.currentNumber = resultTextLabel.text
            }
            
            // If a number is not currently being entered then check if the decimal button has been tapped
        } else {
            resultTextLabel.text = ScoreFormatter.formattedScore(buttonNumber)
            calculator.currentNumber = resultTextLabel.text
            calculator.currentlyTypingNumber = true
        }
        sharedController.saveToPersistentStorage()
    }
    
    // Calculate all objects in the array being passed in
    func runOperation(stackToUse: [Any]) -> Double {
        let operationStack = stackToUse
        var operationString = operationStack.map{ String(describing: $0) }.joined(separator: " ")
        operationString = operationString.replacingOccurrences(of: "÷", with: "/")
        operationString = operationString.replacingOccurrences(of: "x", with: "*")
        let expression = NSExpression(format: operationString, argumentArray: [])
        let value = expression.expressionValue(with: nil, context: nil) as! NSNumber
        return value.doubleValue
    }
    
    // Save current operationStack to History
    @IBAction func saveResultButtonTapped(_ sender: UIButton) {
        var stack = calculator.operationStack
        
        if calculator.currentlyTypingNumber || stack.count == 0 {
            stack.append(resultLabelValue)
            let stackString = stack.map{ String(describing: $0) }.joined(separator: " ")
            let entry = History(historyStack: stackString)
            sharedController.saveHistortyEntry(historyEntry: entry)
        } else {
            let stackString = stack.map{ String(describing: $0) }.joined(separator: " ")
            let entry = History(historyStack: stackString)
            sharedController.saveHistortyEntry(historyEntry: entry)
        }
    }
    
    // Add a decimal to the result text label
    func convertToDecimalNumber(number: String) -> String {
        
        if resultTextLabel.text?.contains(find: ".") == false {
            if calculator.currentlyTypingNumber == false {
                calculator.currentNumber = "."
                return "."
            } else {
                let decimalNumber = number + "."
                calculator.currentNumber = decimalNumber
                return decimalNumber
            }
        }
        return number
    }
    
    // Toggles the current result to either a positive or nagative number
    func positiveOrNegative(currentNumber: Double) -> String {
        var resultValue = currentNumber
        resultValue = resultValue * -1
        calculator.currentNumber = removeTrailingZero(number: resultValue)
        calculator.currentlyTypingNumber = false
        return removeTrailingZero(number: resultValue)
    }
    
    // Removes the ".0" from the Double (number), then initializes it to a String
    func removeTrailingZero(number: Double) -> String {
        let tempNumber = String(format: "%g", number)
        return tempNumber
    }
    
    // Converts a passed in number into a percentage and returns the value
    func percentage(currentNumber: Double) -> Double {
        var stack = calculator.operationStack
        
        if stack.count >= 3 {
            var tempStack = stack
            _ = tempStack.removeLast()
            let stackSum = runOperation(stackToUse: tempStack)
            let decimalNumber = stackSum / 100
            let percentnumber = decimalNumber * currentNumber
            return percentnumber
        } else if stack.count == 0 {
            let decimalNumber = currentNumber / 100
            return decimalNumber
        } else {
            let _ = stack.removeLast()
            let firstNumber = stack.last as! Double
            let decimalNumber = firstNumber / 100
            let percentnumber = decimalNumber * currentNumber
            return percentnumber
        }
    }
    
    //MARK: - DestinationViewControllerDelegate function
    
    // Delegate function used to pass data back from CalculationHistoryViewController
    func passNumberBack(data: [Any]) {
        let lastObject = "\(data.last ?? 0)"
        var dataStack = data
        
        switch lastObject {
            
        case "+", "-", "x", "÷":
            let currentStack = calculator.operationStack.last as? String ?? ""
            
            if currentStack == "+" || currentStack == "-" || currentStack == "x" || currentStack == "÷" {
                calculator.mergeStacks(addToStack: data)
                calculator.currentlyTypingNumber = false
                resultTextLabel.text = "0"
                calculator.currentNumber = "0"
            
            } else if calculator.operationStack.count == 0 {
                calculator.mergeStacks(addToStack: dataStack)
                resultTextLabel.text = "0"
                calculator.currentNumber = "0"
                calculator.currentlyTypingNumber = false
                
            } else {
                calculator.enter(addToStack: resultLabelValue)
                resultTextLabel.text = "0"
                calculator.currentNumber = "0"
                calculator.currentlyTypingNumber = false
                calculator.mergeStacks(addToStack: dataStack)
            }
            
        default:
            if data.count > 2 {
                let labelNumber = "\(dataStack.removeLast())"
                calculator.mergeStacks(addToStack: dataStack)
                resultTextLabel.text = labelNumber.replacingOccurrences(of: ".0", with: "")
                calculator.currentNumber = labelNumber
                calculator.currentlyTypingNumber = true
            } else {
                let labelNumber = "\(dataStack.removeLast())"
                let numberString = labelNumber.replacingOccurrences(of: ".0", with: "")
                resultTextLabel.text = ScoreFormatter.formattedScore(numberString)
                calculator.currentNumber = labelNumber
                calculator.currentlyTypingNumber = true
            }
        }
        sharedController.saveToPersistentStorage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHistoryTable" {
            let navigation = segue.destination as! UINavigationController
            let destinationViewController = navigation.topViewController as! CalculationHistoryViewController
            destinationViewController.delegate = self
        }
    }
}

extension String {
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
}
