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
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                    
                case .Variable(let operand):
                    return "\(operand)"
                    
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
    private var variableValues  = Dictionary<String,Double>()
    
    var description: String? {
        get {
            var infixStack = [String]()
            
            for op in opStack {
                switch op {
                case .Operand(_):
                    infixStack.append(op.description)
                
                case .Variable(_):
                    infixStack.append(op.description)
                    
                case .UnaryOperation(let symbol, _):
                    if infixStack.count >= 1 {
                        if ["√","sin","cos"].contains(symbol) {
                            let lastOp = infixStack.popLast()
                            infixStack.append("(\(symbol)(\(lastOp)))")
                        }
                    }
                
                case .BinaryOperation(let symbol,_):
                    if infixStack.count >= 2 {
                        let op1 = infixStack.popLast()
                        let op2 = infixStack.popLast()
                        
                        infixStack.append("(\(op1) \(symbol) \(op2))")
                    }
                }
            }
            return infixStack.popLast()
        }
    }

    
    init() {
        func learnOp(op:Op) {
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷", {$1 / $0}))
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("-", {$1 - $0}))
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
                return (variableValues[variable],remainingOps)
            
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
        let (result, remainder) = evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder) left over.")
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
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
    func clearStack() {
        opStack = [Op]()
    }
}