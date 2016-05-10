//
//  MinesweeperView.swift
//  minesweeper
//
//  Created by Ellen Widerski on 5/9/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import UIKit

protocol MineViewDataSource: class {
    func widthForMineView(sender: MinesweeperView) -> Int?
    func heightForMineView(sender: MinesweeperView) -> Int?
    func numMinesForMineView(sender: MinesweeperView) -> Int?
}

class MinesweeperView: UIView {
    
    weak var dataSource: MineViewDataSource?
    
    lazy var brain:MinesweeperBrain = MinesweeperBrain(numMines: self.dataSource!.numMinesForMineView(self)!,width: self.dataSource!.widthForMineView(self)!,height: self.dataSource!.heightForMineView(self)!)
    
    var mineButtons = [[UIButton]]()
    
    override func drawRect(rect: CGRect) {
        
        if let ds = dataSource {
            mineButtons = [[UIButton]]()
            brain.restart()
            
            let width = bounds.size.width / CGFloat(ds.widthForMineView(self)!) - 2
            let height = bounds.size.height / CGFloat(ds.heightForMineView(self)!) - 2
            
            for i in 0..<ds.widthForMineView(self)! {
                var row = [UIButton]()
                for j in 0..<ds.heightForMineView(self)! {
                    let mineButton = UIButton(type: UIButtonType.System) as UIButton
                    
                    let x = CGFloat(i)*(width+2)+1
                    let y = CGFloat(j)*(height+2)+1
                    
                    mineButton.frame = CGRectMake(x, y, width, height)
                    mineButton.backgroundColor = UIColor.grayColor()
                    mineButton.addGestureRecognizer(UITapGestureRecognizer(target:self, action: "tap:"))
                    let longtouch = UILongPressGestureRecognizer(target: self, action: "longPress:")
                    longtouch.minimumPressDuration = 0.2
                    mineButton.addGestureRecognizer(longtouch)
                    mineButton.showsTouchWhenHighlighted = true
                    
                    
                    self.addSubview(mineButton)
                    row.append(mineButton)
                }
                
                mineButtons.append(row)
            }

            
            brain.createBoard()
            brain.placeMines()
            brain.placeNumbers()
        }
        
    }
    
    func tap(sender: UITapGestureRecognizer) {
        let button = sender.view as? UIButton
        let col = mineButtons.indexOf { $0.contains(button!) }!
        let row = mineButtons[col].indexOf(button!)!
        if brain.zones[row][col].state {
            
            for i in 0..<brain.zones.count {
                for j in 0..<brain.zones[i].count {
                    if brain.zones[i][j].state && !brain.zones[i][j].marked {
                        mineButtons[j][i].setTitle("💣",forState:UIControlState.Normal)
                    }
                    mineButtons[j][i].backgroundColor = UIColor.lightGrayColor()
                    
                }
            }
            for gesturerecognizer in (button?.gestureRecognizers)! {
                button?.removeGestureRecognizer(gesturerecognizer)
            }
            
        } else {
            brain.openZone(brain.zones[row][col])
            
            for i in 0..<brain.zones.count {
                for j in 0..<brain.zones[i].count {
                    if brain.zones[i][j].revealed {
                        mineButtons[j][i].backgroundColor = UIColor.lightGrayColor()
                        
                        for gesturerecognizer in (mineButtons[j][i].gestureRecognizers)! {
                            mineButtons[j][i].removeGestureRecognizer(gesturerecognizer)
                        }
                        
                        if (brain.zones[i][j].zoneValue != 0) {
                            mineButtons[j][i].setTitle(String(brain.zones[i][j].zoneValue),forState: UIControlState.Normal)
                        }
                    }
                }
            }
        }
    }
    
    func longPress(sender:UILongPressGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.Ended) {
            let button = sender.view as? UIButton
            let col = mineButtons.indexOf { $0.contains(button!) }!
            let row = mineButtons[col].indexOf(button!)!
            
            if brain.zones[row][col].marked {
                brain.zones[row][col].marked = false
                button!.setTitle("", forState: UIControlState.Normal)
                brain.minesLeft += 1
            } else {
                brain.zones[row][col].marked = true
                button!.setTitle("🚩", forState: UIControlState.Normal)
                
                brain.minesLeft -= 1
            }
            if brain.minesLeft == 0 {
            }
        }
    }
}
