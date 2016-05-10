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
    
    var minesLeft: Int = 0 {
        didSet {
            minesLeftLabel.text = String(minesLeft)
        }
    }
    
    var timer = NSTimer()
    var time = 0 {
        didSet {
            timerLabel.text = String(time)
        }
    }
    
    
    @IBOutlet weak var minesLeftLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var restartButton: UIButton!
    @IBAction func restartButton(sender: UIButton) {
        mineView.setNeedsDisplay()
        restartButton.setTitle("😊", forState: UIControlState.Normal)
        resetTime()
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
    
    func minesLeft(mines: Int) {
        minesLeft = mines
        
    }
    
    func lost() {
        restartButton.setTitle("😲", forState: UIControlState.Normal)
        let alert = UIAlertController(title: "You Lose 😥", message: "Try again?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: { action in
                self.mineView.setNeedsDisplay()
                self.restartButton.setTitle("😊", forState: UIControlState.Normal)
            
            }))
        self.presentViewController(alert, animated: true, completion: nil)
        time = 0
        timer.invalidate()
        
    }
    
    func won() {
        timer.invalidate()
        restartButton.setTitle("😎", forState: UIControlState.Normal)
        let score = self.time
        let alert = UIAlertController(title: "You Win! 😄", message: "Score: \(score)\nPlay again?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: { action in
            self.mineView.setNeedsDisplay()
            self.restartButton.setTitle("😊", forState: UIControlState.Normal)
            
        }))
        self.presentViewController(alert, animated: true, completion: {
            action in
            self.timer.invalidate()
            self.time = 0
        })
        
        
    }
    
    func startTime() {
        if time == 0 && !timer.valid {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: #selector(MinesweeperViewController.updateTimerLabel), userInfo: nil, repeats: true)
        }
        else {
            if !timer.valid {
                time = 0
                timer.fire()
            }
        }
    }
    
    func resetTime() {
        timer.invalidate()
        time = 0
        
    }
    
    func updateTimerLabel() {
        time += 1
    }
    
    override func viewDidLoad() {
        minesLeftLabel.text = String(numMines)
        timerLabel.text = "0"
    }
}

