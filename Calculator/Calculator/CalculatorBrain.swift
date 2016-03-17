//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Ellen Widerski on 2/12/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op : CustomStringConvertible {
        case Operand(Double)
        case Variable(String)
        case Pi()
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                    
                case .Variable(let operand):
                    return "\(operand)"
                
                case .Pi():
                    return "π"
                    
                case .UnaryOperation(let symbol,_):
                    return "\(symbol)"
                    
                case .BinaryOperation(let symbol, _):
                    return "\(symbol)"
                }
            }
        }
    }
    
    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    var variableValues  = Dictionary<String,Double>()
    

    var description: String? {
        get {
            let ops = opStack
            return toInfix(ops).result
        }
    }

    
    private func toInfix(ops: [Op]) ->  (result: String?, remainingOps: [Op], lastOp: String?)  {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return ("\(operand)",remainingOps,nil)
                
            case .Variable(let variable):
                return (variable,remainingOps,nil)
                
            case .Pi():
                return ("π",remainingOps,nil)
                
            case .UnaryOperation(let symbol, _):
                let operandEvaluation = toInfix(remainingOps)
                if let operand = operandEvaluation.result {
                    return ("\(symbol)(\(operand))", operandEvaluation.remainingOps, symbol)
                }
                
            case .BinaryOperation(let symbol, _):
                let op1Evaluation = toInfix(remainingOps)
                if var operand1 = op1Evaluation.result {
                    let op2Evaluation = toInfix(op1Evaluation.remainingOps)
                    if var operand2 = op2Evaluation.result {
                        
                        if symbol == "+" || symbol == "−" {
                            return ("\(operand2)\(symbol)\(operand1)",op2Evaluation.remainingOps, symbol)
                        }
                        
                        else if symbol == "×" || symbol == "÷" {
                            if op1Evaluation.lastOp == "+" || op1Evaluation.lastOp == "−" {
                                operand1 = "(\(operand1))"
                            }
                            if op2Evaluation.lastOp == "+" || op2Evaluation.lastOp == "−" {
                                operand2 = "(\(operand2))"
                            }
                            return ("\(operand2)\(symbol)\(operand1)", op2Evaluation.remainingOps, symbol)
                        }
                        else {
                            return ("(\(operand2)\(symbol)\(operand1))", op2Evaluation.remainingOps, symbol)
                        }
                    }
                }
            }
        }
        return ("",ops,nil)
    }
    
    init() {
        func learnOp(op:Op) {
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷", {$1 / $0}))
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("−", {$1 - $0}))
        learnOp(Op.UnaryOperation("√", sqrt))
        learnOp(Op.UnaryOperation("sin",{round(1000 * sin($0)) / 1000}))
        learnOp(Op.UnaryOperation("cos",{round(1000 * cos($0)) / 1000}))

    }
    
    @nonobjc
    private func evaluate(ops:[Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand,remainingOps)
                
            case .Variable(let variable):
                if let varVal = variableValues[variable] {
                    return (varVal,remainingOps)
                }
            case .Pi():
                return (M_PI,remainingOps)
            
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return(operation(operand), operandEvaluation.remainingOps)
                }
                
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1,operand2),op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil,ops)
    }
    
    func evaluate() -> Double? {
        var (result, _) = evaluate(opStack)
        
        if result == -0.0 {
            result = 0.0
        }

//        print("\(opStack) = \(result) with \(remainder) left over.")
        return result
    }

    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    

    func pushOperand(symbol: String) -> Double? {
        opStack.append(Op.Variable(symbol))
        return evaluate()
    }
    
    func pushOperand() -> Double? {
        opStack.append(Op.Pi())
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
    func clearStack() {
        opStack = [Op]()
//        variableValues  = Dictionary<String,Double>()
        variableValues.removeValueForKey("M")
    }
}