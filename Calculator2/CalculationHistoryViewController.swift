//
//  CalculationHistoryViewController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 11/12/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

class CalculationHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: DestinationViewControllerDelegate?
    
    @IBOutlet weak var historyTableView: UITableView!
    
    
    func passDataBackwards(anyData: [Any]) {
        delegate?.passNumberBack(data: anyData)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let calculator = CalculatorController.sharedController.calculators[indexPath.row]
            CalculatorController.sharedController.removeCalculator(calculator: calculator)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let calculator = tableView.indexPathForSelectedRow?.row
        let stackIndex = CalculatorController.sharedController.calculators[calculator!]
        let returnData = stackIndex.operationStack
        passDataBackwards(anyData: returnData)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearHistoryButtonTapped(_ sender: UIButton) {
        CalculatorController.sharedController.clearAllCalculators()
        historyTableView.reloadData()
    }
    
    

}

protocol DestinationViewControllerDelegate {
    func passNumberBack(data: [Any])
}
