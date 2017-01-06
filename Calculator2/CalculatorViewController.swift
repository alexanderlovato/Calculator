//
//  CalculatorViewController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit
import CoreData

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
    var decimalPressed = false
    var resultLabelValue: String {
        let value = resultTextLabel.text ?? "0"
        let returnValue = ScoreFormatter.unformattedNumberString(value)
        guard let returnDouble = returnValue else { return "0" }
        return returnDouble
    }
    
    // MARK: - Calculator singleton
    var calculator = CalculatorController.sharedController.calculators.last ?? Calculator(result: "0", entireOperationString: "", currentNumber: "0")
    
    
    // Temporary Array to hold the stack
    var operationStack: [String] = []
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        
        let opString = calculator.entireOperationString!
        if opString != "" {
            let arrayString = opString.components(separatedBy: " ")
            operationStack = arrayString
        } else {
            CalculatorController.sharedController.saveToPersistentStorage()
        }
        
        resultTextLabel.text = calculator.currentNumber
        
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
//        blurredEffectView.frame = wallpaperImageView!.bounds
//        view.insertSubview(blurredEffectView, aboveSubview: wallpaperImageView)
        
        resultTextLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    // MARK: - View Controller Actions
    
    // Action called when an operation button is selected
    @IBAction func operationAction(_ sender: UIButton) {
        let title = sender.currentTitle
        guard let currentTitle = title else { return }
        
        switch currentTitle {
        
        // Delete button (C)
        case Operations.delete.rawValue:
            
            // Clear operationStack
            delete()
            // Set the result text label to "0"
            resultTextLabel.text = "0"
            // Reset the below boolean variables to false
            calculator.currentlyTypingNumber = false
            finishedEquation = false
            decimalPressed = false
        
        // Positive or Negative button (+/-)
        case Operations.plusMinus.rawValue:
            positiveOrNegative(currentNumber: resultLabelValue)
        
        // Percent button (%)
        case Operations.percent.rawValue:
            let percentValue = percentage(currentNumber: resultLabelValue)
            resultTextLabel.text = percentValue
            
        // The following notes applies to the "÷", "x", "-", and "+" operator cases:
            // Append the current number from the result text label to the operationStack
            // Append the operator being tapped to the operationStack
            // Reset currentlyTypingNumber, finishedEquation, and decimalPressed back to false
        
        // Division button (÷)
        case Operations.division.rawValue:
            enter(addToStack: resultLabelValue)
            enter(addToStack: "÷")
            calculator.currentlyTypingNumber = false
            finishedEquation = false
            decimalPressed = false
        
        // Multiplication button (x)
        case Operations.multiplication.rawValue:
            enter(addToStack: resultLabelValue)
            enter(addToStack: "x")
            calculator.currentlyTypingNumber = false
            finishedEquation = false
            decimalPressed = false
        
        // Subtraction button (-)
        case Operations.subtraction.rawValue:
            enter(addToStack: resultLabelValue)
            enter(addToStack: "-")
            calculator.currentlyTypingNumber = false
            finishedEquation = false
            decimalPressed = false
        
        // Addition button (+)
        case Operations.addition.rawValue:
            enter(addToStack: resultLabelValue)
            enter(addToStack: "+")
            calculator.currentlyTypingNumber = false
            finishedEquation = false
            decimalPressed = false
        
        // Decimal button (.)
        case Operations.decimal.rawValue:
            
            // Adds a decimal to the result text label
            convertToDecimalNumber(number: resultTextLabel.text!)
            
        // Equals button (=)
        case Operations.equals.rawValue:
            
            // Append current number from ResultTextLabel in the OperationStack
            enter(addToStack: resultLabelValue)
            
            // Get the operation stack and put it in "stack"
            let stack = operationStack
            
            // Call runOperation to get the sum of "stack", then store the sum in "result"
            let result = runOperation(stackToUse: stack)
            
            // Now that we have the sum of the operationStack in "result", clear the operationStack
            delete()
            
            // Check in case the equation has not finished.
            // This is to remedy a bug where duplicates of "result" were being appended to the historyObjects array every time the equals button was tapped
            if finishedEquation == false {
                
                // Temporarily add "result" back to operationStack
                enter(addToStack: result)
                // Create a new History object with the current operationStack, then store it in "entry"
                let entry = History(histroyArray: operationStack)
                // Save "entry" to persistent storage
                sharedController.saveHistortyEntry(historyEntry: entry)
                // Clear the operationStack
                delete()
            }
            
            // Format the number to not show ".0" at the end and to show a comma for every third number
            resultTextLabel.text = ScoreFormatter.formattedScore(result)
            
            // Reset currentlyTypingNumber and decimalPressed back to false
            calculator.currentlyTypingNumber = false
            decimalPressed = false
            
            // Since the equation has finished, set this to true
            finishedEquation = true
        default:
            
            // If none of these conditions have been meet when an operator has been tapped, print the below error.
            print("Error in handling calculator operators")
        }
        calculator.currentNumber = resultTextLabel.text
    }
    
    @IBAction func backspaceButtonTapped(_ sender: UIButton) {
        
        // This is a check to make sure we are not saving nil values from the result text label
        if resultTextLabel.text == "" {
            // Reset the result text label to "0"
            resultTextLabel.text = "0"
            calculator.currentNumber = "0"
            // Reset currentlyTypingNumber to false
            calculator.currentlyTypingNumber = false
            
        // If the above check is false
        } else {
            // Unwrap and save the current number in the result text label
            guard let resultText = resultTextLabel.text else { return }
            // Delete the last number in the result text label then store that in "truncated"
            let truncated = resultText.substring(to: resultText.index(before: resultText.endIndex))
            // Set the result text label to show the "truncated" value
            resultTextLabel.text! = truncated
            calculator.currentNumber = truncated
        }
    }
    
    //Action for all input from the number pad
    @IBAction func buttonNumberInput(_ sender: UIButton) {
        
        // Capture the current number being pressed in "buttonNumber"
        let buttonNumber = sender.titleLabel?.text
        // Unformat the current number in the result text label to not show any potential commas
        let unformattedNumber = ScoreFormatter.unformattedNumberString(resultTextLabel.text ?? "0")
        // Capture the currently formatted number in the result text label
        let labelNumber = resultTextLabel.text ?? "0"
        
        // Check if a number is currently being entered
        if calculator.currentlyTypingNumber {
            // Then check if the decimal button has been pressed
            if decimalPressed {
                // Add the tapped number after the decimal point to the result text label
                let number = labelNumber + buttonNumber!
                resultTextLabel.text = number
            
            // If the decimal button has not been tapped
            } else {
                // Add the tapped number to the unformatted number
                let formattedNumber = unformattedNumber! + buttonNumber!
                // Format the new number to show commas for every third number then display that to the result text label
                resultTextLabel.text = ScoreFormatter.formattedScore(formattedNumber)
            }
        
        // If a number is not currently being entered then check if the decimal button has been tapped
            // This is in case a decimal number less than 1 is being tapped
        } else if decimalPressed {
            // Add the tapped number after the decimal point
            resultTextLabel.text = labelNumber + buttonNumber!
            // Set currentlyTypingNumber to true since numbers are currently being entered
            calculator.currentlyTypingNumber = true
        
        // Since no numbers are being entered and the decimal button has not been pressed, run this
        } else {
            // Add the formatted button to the result text label
            resultTextLabel.text = ScoreFormatter.formattedScore(buttonNumber)
            // Set currentlyTypingNumber to true since numbers are currently being entered
            calculator.currentlyTypingNumber = true
        }
        calculator.currentNumber = resultTextLabel.text
    }
    
    func enter(addToStack: String) {
        operationStack.append(addToStack)
        let operationString = operationStack.map{ String(describing: $0) }.joined(separator: " ")
        calculator.entireOperationString = operationString
        print(operationStack)
    }
    
    func mergeStacks(addToStack: [String]) {
        operationStack += addToStack
        let operationString = operationStack.map{ String(describing: $0) }.joined(separator: " ")
        calculator.entireOperationString = operationString
        print(operationStack)
    }
    
    func delete() {
        operationStack.removeAll()
        calculator.entireOperationString = "0"
        print(operationStack)
    }
    
    // Calculate all objects in the array being passed in
    func runOperation(stackToUse: [String]) -> String {
        
        // Capture stackToUse in operationStack because for some reason this was the only way the function would work
        let operationStack = stackToUse
        // Convert all objects to a single String then remove the quotation marks
        var operationString = operationStack.map{ String(describing: $0) }.joined(separator: " ")
        // Replace all "÷" with "/"
        operationString = operationString.replacingOccurrences(of: "÷", with: "/")
        // Replace all "x" with "*"
        operationString = operationString.replacingOccurrences(of: "x", with: "*")
        // Run the expression then capture the new value in "value"
        let expression = NSExpression(format: operationString, argumentArray: [])
        let value = expression.expressionValue(with: nil, context: nil) as! NSNumber
        // Return value as a Double
        return value.stringValue
    }
    
    // Save current operationStack to History
    @IBAction func saveResultButtonTapped(_ sender: UIButton) {
        
        var stack = operationStack
        
        // If the stack is empty but numbers are currently being entered
        if calculator.currentlyTypingNumber || stack.count == 0 {
            stack.append(resultLabelValue)
            let entry = History(histroyArray: stack)
            sharedController.saveHistortyEntry(historyEntry: entry)
        } else {
            let entry = History(histroyArray: stack)
            sharedController.saveHistortyEntry(historyEntry: entry)
        }
    }
    
    // Add a decimal to the result text label
    func convertToDecimalNumber(number: String) {
        
        // Only run if the decimal button has NEVER been tapped for this set of numbers
        if decimalPressed == false {
            
            // If numbers are not being entered add the decimal to the result text label
            if calculator.currentlyTypingNumber == false {
                resultTextLabel.text = "."
                // set decimalPressed to true since a decimal has been entered
                decimalPressed = true
            
            // Since numbers are currently being entered run this
            } else {
                // Add a decimal to the current number in result text label
                let decimalNumber = number + "."
                resultTextLabel.text = decimalNumber
                // set decimalPressed to true since a decimal has been entered
                decimalPressed = true
            }
        }
        
        calculator.currentNumber = resultTextLabel.text
    }
    
    func positiveOrNegative(currentNumber: String) {
        
        var resultValue = Double(currentNumber) ?? 0
        resultValue = resultValue * -1
        resultTextLabel.text = removeTrailingZero(number: resultValue)
        calculator.currentlyTypingNumber = false
        calculator.currentNumber = resultTextLabel.text
    }
    
    func removeTrailingZero(number: Double) -> String {
        let tempNumber = String(format: "%g", number)
        return tempNumber
    }
    
    ///Converts a passed in number into a percentage and returns the value
    func percentage(currentNumber: String) -> String {
        
        var stack = operationStack
        
        if stack.count > 3 {
            var tempStack = stack
            _ = tempStack.removeLast()
            let stackSum = Double(runOperation(stackToUse: tempStack)) ?? 0
            let decimalNumber = stackSum / 100
            let percentnumber = decimalNumber * Double(currentNumber)!
            return "\(percentnumber)"
        } else if stack.count == 0 {
            let decimalNumber = Double(currentNumber)! / 100
            return "\(decimalNumber)"
        } else {
            let _ = stack.removeLast()
            let firstNumber = Double(stack.last!) ?? 0
            let decimalNumber = firstNumber / 100
            let percentnumber = decimalNumber * Double(currentNumber)!
            return "\(percentnumber)"
        }
    }
    
    //MARK: - DestinationViewControllerDelegate function
    ///Delegate function used to pass data back from CalculationHistoryViewController
    func passNumberBack(data: [String]) {
        let lastObject = "\(data.last!)"
        var dataStack = data
        
        switch lastObject {
            
        //Check if the last object from the selected History table is an operator
        case "+", "-", "x", "÷":
            let currentStack = operationStack.last ?? "0"
            
            //Then check if the last object of the operationStack is an operator
            if currentStack == "+" || currentStack == "-" || currentStack == "x" || currentStack == "÷" {
                mergeStacks(addToStack: data)
                calculator.currentlyTypingNumber = false
                resultTextLabel.text = "0"
                
            } else if operationStack.count == 0 {
                //Since neither stacks end with an operator: Remove last number from selected histroy stack, merge that stack with the operatorStack, then set the resultTextLabel to the last removed object of history stack
                mergeStacks(addToStack: dataStack)
                resultTextLabel.text = "0"
                calculator.currentlyTypingNumber = false
            } else {
                enter(addToStack: resultLabelValue)
                resultTextLabel.text = "0"
                calculator.currentlyTypingNumber = false
                mergeStacks(addToStack: dataStack)
            }
        default:
            if data.count > 2 {
                let labelNumber = dataStack.removeLast()
                mergeStacks(addToStack: dataStack)
                resultTextLabel.text = labelNumber
                calculator.currentlyTypingNumber = true
            } else {
                //If none of the above scenarios match then execute this block of code
                let labelNumber = dataStack.removeLast()
                resultTextLabel.text = labelNumber
                calculator.currentlyTypingNumber = true
            }
        }
        
        calculator.currentNumber = resultTextLabel.text
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
