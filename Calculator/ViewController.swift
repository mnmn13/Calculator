//
//  ViewController.swift
//  Calculator
//
//  Created by MN on 09.11.2022.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    
    @IBOutlet var swipe: UISwipeGestureRecognizer!
    @IBOutlet weak var equalButtonOutlet: UIButton!
    @IBOutlet weak var plusButtonOutlet: UIButton!
    @IBOutlet weak var substractButtonOutlet: UIButton!
    @IBOutlet weak var multiplyButtonOutlet: UIButton!
    @IBOutlet weak var divideButtonOutlet: UIButton!
    @IBOutlet weak var AC: UIButton!
    
    @IBOutlet weak var viewHolder: UIView!
    
    var startNumber = 0
    var firstNumber = 0
    var resultNumber: Double = 0
    var operation: Int? = nil
    var option = false
    
    var numberFromScreen: Double = 0
    var firstNum: Double = 0
    var firstTempNumber: Double = 0
    var secondTempNumber: Double = 0
    let hundred: Double = 100
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otherSet()
        swipeSet()
    }
    
    func otherSet() {
        view.backgroundColor = .black
        resultLabel.text = "\(startNumber)"
        viewHolder.backgroundColor = .black
    }
    
    
    func swipeSet() {
        swipe = UISwipeGestureRecognizer(target: self, action: #selector(userSwiped))
        swipe.direction = .left
        view.addGestureRecognizer(swipe)
    }
    
    
    
    @objc func userSwiped(_ gesture:UISwipeGestureRecognizer) {
        
        if let text = resultLabel.text, !text.isEmpty, text != "0" {
            resultLabel.text = String(text.dropLast())
            if resultLabel.text == "" {
                resultLabel.text = "0"
            }
        
        }
        
    }
    
    
    @IBAction func signChange(_ sender: UIButton) {
        guard let result = resultLabel.text,
              let result2 = Double(result) else { return }
        
        let result3 = -result2
        resultLabel.text = String(format: "%g", result3)
        sound()
    }
    
    @IBAction func ACButton(_ sender: UIButton) {
        resultLabel.text = "0"
        firstNumber = 0
        firstNum = 0
        resultNumber = 0
        sound()
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
        
        guard sender.tag != 13 else {
            print("resultNumber - \(secondTempNumber), firstTempNumber - \(firstTempNumber), hundred -\(hundred) ")
            resultLabel.text = String(format: "%g", resultNumber)
            return
        }
        sound()
    }
    
    
    
    @IBAction func percentCount(_ sender: UIButton) {
        
        if let text = resultLabel.text, !text.isEmpty, sender.tag == 13 {
            
            secondTempNumber = 0.0
            resultNumber = firstNum * (Double(resultLabel.text!) ?? 0.0) / hundred
    //        print(firstNum)
      //      print(resultLabel.text ?? "")
            option = true
            resultLabel.text = String(format: "%g", resultNumber)
        }
        sound()
    }
    
    @IBAction func calculationButton(_ sender: UIButton) {
     
        if let text = resultLabel.text, !text.isEmpty, sender.tag != 18 {
            firstNum = Double(text) ?? 0
            firstTempNumber = firstNum
            print(firstTempNumber)
            switch sender.tag {
            case 14:
            
                resultLabel.text = "/"
            case 15:
                resultLabel.text = "x"
            case 16:
                resultLabel.text = "-"
            case 17:
                resultLabel.text = "+"
                
 //               resultNumber = secondTempNumber
            default:
                print("Error (calculationButton)")
            }

            operation = sender.tag
            option = true
        } else if sender.tag == 18 {
            guard operation != nil else { return }
            var result = 0.0
            
            
            switch operation {
            case 17:
                result = firstNum + resultNumber
            case 16:
                result = firstNum - resultNumber
            case 15:
                result = firstNum * resultNumber
            case 14:
                result = firstNum / resultNumber
            default:
                print("Error (calculation)")
            }

            resultLabel.text = String(format: "%g", result)
        }
        
        sound()
        
    }
    func sound() {
        AudioServicesPlaySystemSound(1306)
    }
}
