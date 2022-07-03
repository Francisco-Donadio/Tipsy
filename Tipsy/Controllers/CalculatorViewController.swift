//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    
    var tipSelected = "10%"
    var decimalTip = 0.10
    var billTotal = 0.00
    var numberOfPeople = 2
    var finalResult = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
      
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
    
        tipSelected = sender.currentTitle!
        
        let tipMinusPercentSign = String(tipSelected.dropLast())
        let tipAsANumber = Double(tipMinusPercentSign)!
        decimalTip = tipAsANumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    

    @IBAction func calculatePresssed(_ sender: UIButton) {
        
        let bill = billTextField.text!
        
        if bill != "" {
            billTotal = Double(bill)!
            let result = billTotal * (1 + decimalTip) / Double(numberOfPeople)
            finalResult = String(format: "%.2f", result)
        }
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult" {
            
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.people = numberOfPeople
            destinationVC.tip = tipSelected
            destinationVC.total = finalResult
        }
    }
}

