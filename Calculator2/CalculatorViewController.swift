//
//  CalculatorViewController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var resultTextLabel: UILabel!
    
    var resultLabelValue: Double {
        let value = resultTextLabel.text ?? "0"
        return Double(value) ?? 0
    }
    
    var results = NumberController.sharedController.result
    var currentlyTypingNumber = NumberController.sharedController.currentlyTypingNumber
    var currentOp = NumberController.sharedController.operation
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func divisionButtonTapped(_ sender: UIButton) {
        
        currentOp = sender.currentTitle!
        NumberController.sharedController.enter(currentNumber: resultLabelValue)
        currentlyTypingNumber = false
    }
    
    @IBAction func multiplicationButtonTapped(_ sender: UIButton) {
        
        currentOp = sender.currentTitle!
        NumberController.sharedController.enter(currentNumber: resultLabelValue)
        currentlyTypingNumber = false
    }
    
    @IBAction func subtractionButtonTapped(_ sender: UIButton) {
        
        currentOp = sender.currentTitle!
        NumberController.sharedController.enter(currentNumber: resultLabelValue)
        currentlyTypingNumber = false
    }
    
    @IBAction func additionButtonTapped(_ sender: UIButton) {
        
        currentOp = sender.currentTitle!
        NumberController.sharedController.enter(currentNumber: resultLabelValue)
        currentlyTypingNumber = false
    }
    
    @IBAction func equalsButtonTapped(_ sender: UIButton) {
        
        NumberController.sharedController.setOperator(operatorString: currentOp)
        resultTextLabel.text = "\(results)"
        currentlyTypingNumber = false
        
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        
        NumberController.sharedController.delete()
        resultTextLabel.text = "0"
        results = Double(resultTextLabel.text!) ?? 0
        currentlyTypingNumber = false
    }
    
    @IBAction func negateButtonPressed(_ sender: UIButton) {
        let resultValue = abs(resultLabelValue)
        resultTextLabel.text = "\(resultValue)"
        currentlyTypingNumber = false
        
    }
    
    
    

}
