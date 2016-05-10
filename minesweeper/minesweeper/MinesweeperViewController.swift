//
//  ViewController.swift
//  minesweeper
//
//  Created by Ellen Widerski on 5/8/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import UIKit

class MinesweeperViewController: UIViewController, MineViewDataSource {
    var width: Int = 0
    var height: Int = 0
    var numMines: Int = 0
    
    @IBOutlet weak var minesLeftLabel: UILabel! {
    
    @IBAction func restartButton(sender: UIButton) {
        mineView.setNeedsDisplay()
    }
    

    @IBOutlet weak var mineView: MinesweeperView! {
        didSet {
            mineView.dataSource = self
        }
    }
    
    func widthForMineView(sender: MinesweeperView) -> Int? {
        return width
    }
    func heightForMineView(sender: MinesweeperView) -> Int? {
        return height
    }
    func numMinesForMineView(sender: MinesweeperView) -> Int? {
        return numMines
    }
    
    override func viewDidLoad() {
        minesLeftLabel.text = String(numMines)
    }
}

