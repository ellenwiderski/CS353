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

    @IBOutlet weak var die1: UIButton!
    @IBOutlet weak var die2: UIButton!
    @IBOutlet weak var die3: UIButton!
    @IBOutlet weak var die4: UIButton!
    @IBOutlet weak var die5: UIButton!
    
    var dieButtons = [UIButton]()
    
    override func viewDidLoad() {
        self.dieButtons = [die1,die2,die3,die4,die5]
    }
    
    @IBAction func roll() {
        myCup.shake()
        update()
    }
    
    func update() {
        for i in 0..<5 {
            if let diceVal = diceDict[myCup.getDie(i)] {
                self.dieButtons[i].setTitle(diceVal,forState: .Normal)
            }
        }
    }
    
    
}

