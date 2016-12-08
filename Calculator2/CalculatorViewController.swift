//
//  CalculatorViewController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, DestinationViewControllerDelegate, CardCollectionTransitionDelegate {
    
    //MARK: - Enumerators
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
    
    //MARK: - Outlets
    @IBOutlet weak var wallpaperImageView: UIImageView!
    @IBOutlet weak var resultTextLabel: UILabel!
    @IBOutlet weak var entireExpressionLabel: UILabel!
    
    //MARK: - Shared Controller
    let sharedController = CalculatorController.sharedController
    
    //MARK: - Properties
    var finishedEquation = false
    var resultLabelValue: Double {
        let value = resultTextLabel.text ?? "0"
        let returnValue = ScoreFormatter.unformattedNumberString(value)
        guard let returnDouble = returnValue else { return 0 }
        return Double(returnDouble) ?? 0
    }
    
    //MARK: - Calculator singleton
    var calculator = Calculator()
    var cardIndex = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        updateWithCalculator()
        
        //The below code is a placeholder for bluring the background. Not sure if I want to use this or if I want to make this into a toggle function
        
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
//        blurredEffectView.frame = wallpaperImageView!.bounds
//        view.insertSubview(blurredEffectView, aboveSubview: wallpaperImageView)
        
    }
    
    
    //MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    //MARK: - Storyboard Actions
    
    ///Back Bar Button Item used to return back to CardCollectionViewController
    @IBAction func customBack(_ sender: Any) {
        let calculatorIndex = CalculatorController.sharedController.calculators[cardIndex.row]
        calculatorIndex.result = resultLabelValue
        calculatorIndex.screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        calculatorIndex.currentlyTypingNumber = calculator.currentlyTypingNumber
        calculatorIndex.operationStack = calculator.operationStack
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func operationAction(_ sender: UIButton) {
        let title = sender.currentTitle
        
        guard let currentTitle = title else { return }
        
        switch currentTitle {
        
        case Operations.delete.rawValue:
            calculator.delete()
            resultTextLabel.text = "0"
            calculator.currentlyTypingNumber = false
            finishedEquation = false
        
        case Operations.plusMinus.rawValue:
            positiveOrNegative(currentNumber: resultLabelValue)
        
        case Operations.percent.rawValue:
            let percentValue = sharedController.percentage(currentNumber: resultLabelValue)
            resultTextLabel.text = removeTrailingZero(number: percentValue)
        
        case Operations.division.rawValue:
            calculator.enter(addToStack: resultLabelValue)
            calculator.enter(addToStack: "÷")
            calculator.currentlyTypingNumber = false
            finishedEquation = false
            
        case Operations.multiplication.rawValue:
            calculator.enter(addToStack: resultLabelValue)
            calculator.enter(addToStack: "x")
            calculator.currentlyTypingNumber = false
            finishedEquation = false
        
        case Operations.subtraction.rawValue:
            calculator.enter(addToStack: resultLabelValue)
            calculator.enter(addToStack: "-")
            calculator.currentlyTypingNumber = false
            finishedEquation = false
        
        case Operations.addition.rawValue:
            calculator.enter(addToStack: resultLabelValue)
            calculator.enter(addToStack: "+")
            calculator.currentlyTypingNumber = false
            finishedEquation = false
        
        case Operations.decimal.rawValue:
            convertToDecimalNumber(number: resultTextLabel.text!)
        
        case Operations.equals.rawValue:
            calculator.enter(addToStack: resultLabelValue)
            let stack = calculator.operationStack
            let result = sharedController.runOperation(stackToUse: stack)
            calculator.delete()
            
            if finishedEquation == false {
                calculator.enter(addToStack: result)
                
                //TODO: - Need to create an new way to save calculation history
                
//                let calculator = self.calculator
//                sharedController.saveCalculatorTab(calculatorTab: calculator)
                calculator.delete()
            }
            let labelResult = removeTrailingZero(number: result)
            resultTextLabel.text = ScoreFormatter.formattedScore(labelResult)
            calculator.currentlyTypingNumber = false
            finishedEquation = true
        default:
            print("Error")
        }
    }
    
    @IBAction func backspaceButtonTapped(_ sender: UIButton) {
        if resultTextLabel.text == "" {
            resultTextLabel.text = "0"
            calculator.currentlyTypingNumber = false
        } else {
            guard let resultText = resultTextLabel.text else { return }
            let truncated = resultText.substring(to: resultText.index(before: resultText.endIndex))
            resultTextLabel.text! = truncated
        }
    }
    
    //Function for all number input from the number pad
    @IBAction func buttonNumberInput(_ sender: UIButton) {
        
        let buttonNumber = sender.titleLabel?.text
        let unformattedNumber = ScoreFormatter.unformattedNumberString(resultTextLabel.text!)
        
        if calculator.currentlyTypingNumber {
            let formattedNumber = unformattedNumber! + buttonNumber!
            
            resultTextLabel.text = ScoreFormatter.formattedScore(formattedNumber)
            entireExpressionLabel.text = ScoreFormatter.formattedScore(formattedNumber)
        } else {
            resultTextLabel.text = ScoreFormatter.formattedScore(buttonNumber)
            entireExpressionLabel.text = ScoreFormatter.formattedScore(buttonNumber)
            calculator.currentlyTypingNumber = true
        }
    }
    
    
    //TODO: - Need to create a new place to store History
    @IBAction func saveResultButtonTapped(_ sender: UIButton) {
        
//        let stack = sharedController.calculator.operationStack
//        
//        if currentlyTypingNumber || stack.count == 0 {
//            var currentStack = sharedController.calculator.operationStack
//            currentStack.append(resultLabelValue)
//            let calculator = Calculator(result: resultLabelValue, operationStack: currentStack, currentlyTypingNumber: currentlyTypingNumber)
//            sharedController.saveCalculatorTab(calculatorTab: calculator)
//        } else {
//            
//            let calculator = Calculator(result: resultLabelValue, operationStack: sharedController.calculator.operationStack, currentlyTypingNumber: currentlyTypingNumber)
//            sharedController.saveCalculatorTab(calculatorTab: calculator)
//        }
    }
    
    //TODO: - Currently broken by the decimal formatting from ScoreFormatter
    func convertToDecimalNumber(number: String) {
        let decimalNumber = number + "."
        resultTextLabel.text = decimalNumber
    }
    
    //Adds or removes a "-" from the current number to convert it from positive to negative
    func positiveOrNegative(currentNumber: Double) {
        var resultValue = currentNumber
        resultValue = resultValue * -1
        resultTextLabel.text = removeTrailingZero(number: resultValue)
         calculator.currentlyTypingNumber = false
    }
    
    //Since the numbers are all Double types, this is meant to remove the trailing zero that's always present in Double number types
    func removeTrailingZero(number: Double) -> String {
        let tempNumber = String(format: "%g", number)
        return tempNumber
    }
    
    //MARK: - DestinationViewControllerDelegate function
    ///Delegate function used to pass data back from CalculationHistoryViewController
    func passNumberBack(data: [Any]) {
        let lastObject = "\(data.last!)"
        var dataStack = data
        
        switch lastObject {
            
        //Check if the last object from the selected History table is an operator
        case "+", "-", "x", "÷":
            let currentStack = calculator.operationStack.last as? String ?? ""
            
            //Then check if the last object of the operationStack is an operator
            if currentStack == "+" || currentStack == "-" || currentStack == "x" || currentStack == "÷" {
                calculator.mergeStacks(addToStack: data)
                calculator.currentlyTypingNumber = false
                resultTextLabel.text = "0"
            
            } else if calculator.operationStack.count == 0 {
                //Since neither stacks end with an operator: Remove last number from selected histroy stack, merge that stack with the operatorStack, then set the resultTextLabel to the last removed object of history stack
                calculator.mergeStacks(addToStack: dataStack)
                resultTextLabel.text = "0"
                calculator.currentlyTypingNumber = false
            } else {
                calculator.enter(addToStack: resultLabelValue)
                resultTextLabel.text = "0"
                calculator.currentlyTypingNumber = false
                calculator.mergeStacks(addToStack: dataStack)
            }
        default:
            if data.count > 2 {
                let labelNumber = removeTrailingZero(number: dataStack.removeLast() as! Double)
                calculator.mergeStacks(addToStack: dataStack)
                resultTextLabel.text = labelNumber
                calculator.currentlyTypingNumber = true
            } else {
                //If none of the above scenarios match then execute this block of code
                let labelNumber = removeTrailingZero(number: dataStack.removeLast() as! Double)
                resultTextLabel.text = labelNumber
                calculator.currentlyTypingNumber = true
            }
        }
    }
    
    //MARK: - CardCollectionTransitionDelegate function
    ///Delegate Function used to pass data back from CardCollectionViewController
    func passDataToCalculatorView(calculator: Calculator, index: IndexPath) {
        //Update all values in calculator singleton
        self.calculator = calculator
        self.cardIndex = index
    }
    
    //Update the textLabel values
    func updateWithCalculator() {
        guard let result = calculator.result else { return }
        resultTextLabel.text = removeTrailingZero(number: result)
        var minimalDescription = calculator.entireOperationString.map{ String(describing: $0) }.joined(separator: " ")
        minimalDescription = minimalDescription.replacingOccurrences(of: ".0", with: "")
        entireExpressionLabel.text = minimalDescription
    }
    
    //MARK: - Navigation
    ///Storyboard segue used for delcaring the delegate for protocol DestinationViewControllerDelegate
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
