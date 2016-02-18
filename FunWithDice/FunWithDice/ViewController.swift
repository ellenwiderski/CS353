//
//  ViewController.swift
//  FunWithDice
//
//  Created by Ellen Widerski on 2/18/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var myCup = Cup(numDice: 6, numSides: 6)
    let diceDict: [Int:String] = [1:"⚀",2:"⚁",3:"⚂",4:"⚃",5:"⚄",6:"⚅"]
    
    @IBOutlet var dieCollection: [UIButton]!
    
    
    @IBAction func roll() {
        myCup.shake()
        for i in 1..<6 {
            if let diceVal = diceDict[myCup.getDie(i)] {
                dieCollection[i].setTitle(diceVal, forState: .Normal)
            }
        }
    }
    
    @IBAction func freeze(sender: UIButton) {
        if (myCup.getDice()[sender.tag].isFrozen()) {
            myCup.unfreezeDie(sender.tag)
            dieCollection[sender.tag].setTitleColor(UIColor(red: 0, green: 122/255, blue: 1, alpha: 1), forState: .Normal)
        }
        else {
            myCup.freezeDie(sender.tag)
            dieCollection[sender.tag].setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
    }
}

