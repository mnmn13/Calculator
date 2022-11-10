//
//  ViewController.swift
//  Calculator
//
//  Created by MN on 09.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var equalButtonOutlet: UIButton!
    @IBOutlet weak var plusButtonOutlet: UIButton!
    @IBOutlet weak var substractButtonOutlet: UIButton!
    @IBOutlet weak var multiplyButtonOutlet: UIButton!
    @IBOutlet weak var divideButtonOutlet: UIButton!
    @IBOutlet weak var persentButtonOutlet: UIButton!
    
    @IBOutlet weak var viewHolder: UIView!
    
    var startNumber = 0
    var firstNumber = 0
    var resultNumber: Double = 0
    var operation: Int? = nil
    var option = false
    
    var numberFromScreen: Double = 0
    var firstNum: Double = 0
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        resultLabel.text = "\(startNumber)"
        viewHolder.backgroundColor = .black
        
    }
    @IBAction func signChange(_ sender: UIButton) {
        guard let result = resultLabel.text,
              let result2 = Double(result) else { return }
        
        let result3 = -result2
        resultLabel.text = String(format: "%g", result3)
        
    }
    
    @IBAction func ACButton(_ sender: UIButton) {
        resultLabel.text = "0"
        firstNumber = 0
        firstNum = 0
        resultNumber = 0
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        guard sender.tag != 10 else {
            if option == true {
                resultLabel.text = String(sender.tag)
                option = false
            } else if !resultLabel.text!.contains(".") {
                resultLabel.text = resultLabel.text! + "."
            }
            resultNumber = Double(resultLabel.text!) ?? 0
            return
        }
        if option == true {
            if resultLabel.text == "0" {
                resultLabel.text = ""
            }
            resultLabel.text = String(sender.tag)
            option = false
        } else {
            if resultLabel.text == "0" {
                resultLabel.text = ""
            }
            resultLabel.text = resultLabel.text! + String(sender.tag)
        }
        resultNumber = Double(resultLabel.text!) ?? 0
    }
    @IBAction func calculationButton(_ sender: UIButton) {
        
        
        
        if let text = resultLabel.text, !text.isEmpty, sender.tag != 18 {
            firstNum = Double(text) ?? 0
            
            switch sender.tag {
            case 14:
                resultLabel.text = "/"
            case 15:
                resultLabel.text = "x"
            case 16:
                resultLabel.text = "-"
            case 17:
                resultLabel.text = "+"
            default:
                print("Error (calculationButton)")
            }
            operation = sender.tag
            option = true
        } else if sender.tag == 18 {
            guard operation != nil else { return }
            var result = 0.0
            
            
            if operation == 17 {
                result = firstNum + resultNumber
            } else if operation == 16 {
                result = firstNum - resultNumber
            } else if operation == 15 {
                result = firstNum * resultNumber
            } else if operation == 14 {
                result = firstNum / resultNumber
            }
            resultLabel.text = String(format: "%g", result)
        }
        
    }
}
