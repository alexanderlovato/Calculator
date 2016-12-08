//
//  CalculationHistoryViewController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 11/12/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

class CalculationHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Delegate declaration
    var delegate: DestinationViewControllerDelegate?
    
    @IBOutlet weak var historyTableView: UITableView!
    
    //MARK: - Calling delegate function to return data to CalculatorViewController
    func passDataBackwards(anyData: [Any]) {
        delegate?.passNumberBack(data: anyData)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CalculatorController.sharedController.calculators.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalculatorCell", for: indexPath)
        let calculator = CalculatorController.sharedController.calculators[indexPath.row]
        var minimalDescription = calculator.operationStack.map{ String(describing: $0) }.joined(separator: " ")
        minimalDescription = minimalDescription.replacingOccurrences(of: ".0", with: "")
        cell.textLabel?.text = minimalDescription
        return cell
    }
    
    
    //TODO: - Calculator History still needs to be rebult and reconfigured
    // MARK: - TableView Editing
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let calculator = CalculatorController.sharedController.calculators[indexPath.row]
            CalculatorController.sharedController.removeCalculator(calculator: calculator)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let calculator = tableView.indexPathForSelectedRow?.row
        let stackIndex = CalculatorController.sharedController.calculators[calculator!]
        let returnData = stackIndex.operationStack
        passDataBackwards(anyData: returnData)
        self.dismiss(animated: true, completion: nil)
    }
    
    //Dismisses the viewController
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Clears all result and operation data from History (TBD)
    @IBAction func clearHistoryButtonTapped(_ sender: UIButton) {
        CalculatorController.sharedController.clearAllCalculators()
        historyTableView.reloadData()
    }
    
    

}

// MARK: - Return data to CalculatorViewController Delegate
protocol DestinationViewControllerDelegate {
    func passNumberBack(data: [Any])
}
