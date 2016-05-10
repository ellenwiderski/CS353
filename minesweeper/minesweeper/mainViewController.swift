//
//  mainViewController.swift
//  minesweeper
//
//  Created by Ellen Widerski on 5/9/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        
        if let mvc = destination as? MinesweeperViewController {
            switch(segue.identifier!) {
                case "easy":
                mvc.width = 5
                mvc.height = 10
                mvc.numMines = 8
                case "medium":
                mvc.width = 10
                mvc.height = 20
                mvc.numMines = 20
                case "hard":
                mvc.width = 12
                mvc.height = 25
                mvc.numMines = 35
                default:
                mvc.width = 0
                mvc.height = 0
                mvc.numMines = 0
            }
        }
    }
}
