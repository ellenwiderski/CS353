//
//  DiceModel.swift
//  FunWithDice
//
//  Created by Ellen Widerski on 2/18/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import Foundation

class MSDie {
    var numSides: Int
    private var currentValue: Int
    var isFrozen: Bool
    
    init (numSides: Int) {
        self.numSides = numSides
        currentValue = random() % numSides + 1
        isFrozen = false
    }
    
    func roll() -> Int {
        currentValue = random() % numSides + 1
        return currentValue
    }
    
    func freeze() {
        isFrozen = true
    }
    
    var value: Int {
        get {
            return currentValue
        }
        set {
            print("No Cheating")
        }
    }
}


class Cup {
    var myDice = [MSDie]()
    var possibleValues = [String]()
    
    init(numDice: Int, numSides: Int) {
        for _ in 0..<numDice {
            myDice.append(MSDie(numSides: numSides))
        }
    }
    
    convenience init(withNumDice numDice: Int) {
        self.init(numDice: numDice, numSides: 6)
    }
    
    convenience init(withPossibleValues values: [String]) {
        self.init(numDice: 6, numSides: 6)
        self.possibleValues = values
    }
    
    func shake() {
        for d in myDice {
            d.roll()
        }
    }
    
    func getDie(idx:Int) -> Int {
        return myDice[idx].currentValue
    }
    
}