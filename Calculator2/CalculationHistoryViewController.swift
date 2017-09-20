//
//  CalculationHistoryViewController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 11/12/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

class CalculationHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Destination delegate
    var delegate: DestinationViewControllerDelegate?
    
    //MARK: - Outlets
    @IBOutlet weak var historyTableView: UITableView!
    
    //MARK: - Destination delegate method
    func passDataBackwards(anyData: [Any]) {
        delegate?.passNumberBack(data: anyData)
    }
    
    //MARK: - UITableView Datasource
    
    // Delegate method called to indicate the number of TableView rows in the section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CalculatorController.sharedController.history.count
    }
    
    // Delegate method called to indicate the data that will be used
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalculatorCell", for: indexPath)
        let history = CalculatorController.sharedController.history[indexPath.row]
        let data = history.historyStack!.replacingOccurrences(of: ".0", with: "")
        
        if data.contains(find: "÷") || data.contains(find: "x") || data.contains(find: "-") || data.contains(find: "+") {
            cell.textLabel?.text = data
            return cell
        } else {
            cell.textLabel?.text = ScoreFormatter.formattedScore(data)
            return cell
        }
    }
    
    //MARK: - UITableView Delegate
    
    // Delegate method called to enable swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let history = CalculatorController.sharedController.history[indexPath.row]
            CalculatorController.sharedController.remove(historyEntry: history)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Delegate method called when a TableView row has been tapped
    // Passes the data from the TableView row and transitions back to CalculatorViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = tableView.indexPathForSelectedRow?.row
        let stackIndex = CalculatorController.sharedController.history[entry!]
        let returnString = stackIndex.historyStack
        let returnData = returnString!.components(separatedBy: " ")
        passDataBackwards(anyData: returnData)
        self.dismiss(animated: true, completion: nil)
    }
    
    // Transitions back to CalculatorViewController
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Clears all data from the TableView
    @IBAction func clearHistoryButtonTapped(_ sender: UIButton) {
        CalculatorController.sharedController.clearAllHistoryEntires()
        historyTableView.reloadData()
    }
}

// MARK: - Destination Delegate Protocol
protocol DestinationViewControllerDelegate {
    func passNumberBack(data: [Any])
}
