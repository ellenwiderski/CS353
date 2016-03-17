//
//  ViewController.swift
//  Calculator
//
//  Created by Ellen Widerski on 2/7/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false

    var brain = CalculatorBrain()
    
    
    @IBAction func pushM() {
        brain.pushOperand("M")
        historyValue += "M"
    }
    
    @IBAction func setM() {
        brain.variableValues["M"] = displayValue
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.evaluate() {
            displayValue = result
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func appendDecimal() {
        if display.text!.rangeOfString(".") == nil && userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + "."
        }
    }
    
    @IBAction func pi() {
        display.text = "π"
        enter()
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if var operation = sender.currentTitle {
            if operation == "sin(θ)" { operation = "sin" }
            if operation == "cos(θ)" { operation = "cos" }
            
            if let result = brain.performOperation(operation) {
                displayValue = result
                historyValue = brain.description!
            }
            else {
                displayValue = nil
            }
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if display.text! == "π" {
            if let result = brain.pushOperand() {
                displayValue = result
                historyValue += "π"
            }
        }
        else if let dval = displayValue {
            if let result = brain.pushOperand(dval) {
                displayValue = result
                historyValue += "\(result)"
            }
        }
        else {
            displayValue = nil
            historyValue = ""
        }
    }
    
    @IBAction func clear() {
        displayValue = nil
        historyValue = ""
        brain.clearStack()
    }
    
    //property
    var displayValue: Double? {
        get {
            if let dtxt = NSNumberFormatter().numberFromString(display.text!) {
                return dtxt.doubleValue
            }
            else {
                return nil
            }
        }
        set {
            if newValue == nil {
                display.text = " "
            }
            else {
                display.text = "\(newValue!)"
            }
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    var historyValue: String {
        get {
            return history.text!
        }
        set {
            history.text = " \(newValue) "
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

