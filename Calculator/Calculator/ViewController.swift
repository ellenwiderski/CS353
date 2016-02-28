//
//  ViewController.swift
//  Calculator
//
//  Created by Ellen Widerski on 2/7/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false

    var brain = CalculatorBrain()
    
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
        display.text = "\(M_PI)"
        enter()
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            historyValue += operation
            if let result = brain.performOperation(operation) {
                displayValue = result
            }
            else {
                displayValue = 0
            }
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let dval = displayValue {
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
        displayValue = 0
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
                display.text = ""
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

