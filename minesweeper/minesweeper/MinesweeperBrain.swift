//
//  minesweeperbrain.swift
//  minesweeper
//
//  Created by Ellen Widerski on 5/8/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import Foundation

class MinesweeperBrain {
    
    var numMines = 0
    var width = 0
    var height = 0
    var zones = [[Zone]]()
    
    var minesLeft = 0
    
    init(numMines: Int, width: Int, height: Int) {
        self.numMines = numMines
        self.width = width
        self.height = height
        self.minesLeft = numMines
    }
    
    struct Zone {
        var state: Bool
        var revealed: Bool
        var xcor: Int
        var ycor: Int
        var marked: Bool
        var zoneValue: Int
        
        init(x: Int, y: Int) {
            self.state = false
            self.revealed = false
            self.xcor = x
            self.ycor = y
            self.marked = false
            self.zoneValue = 0
        }
    }
    
    func createBoard() {
        for i in 0..<height {
            let hzones = [Zone]()
            zones.append(hzones)
            for j in 0..<width {
                let newZone = Zone(x: j,y: i)
                zones[i].append(newZone)
                
            }
        }
    }
    
    func placeMines() {
        var bombCounter = numMines
        while bombCounter > 0 {
            let rand = Int(arc4random_uniform(UInt32(width*height)))
            let row = Int(rand/width)
            let col = rand % width
            
            if (!zones[row][col].state) {
                zones[row][col].state = true
                bombCounter -= 1
            }
        }
    }
    
    func getNeighbors(z:Zone) -> Array<Zone> {
        var neighborsArray = [Zone]()
        if z.ycor == 0 {
            neighborsArray.append(zones[z.ycor + 1][z.xcor])
            if z.xcor == 0 {
                neighborsArray.append(zones[z.ycor][z.xcor + 1])
                neighborsArray.append(zones[z.ycor + 1][z.xcor + 1])
            } else if z.xcor == (width-1) {
                neighborsArray.append(zones[z.ycor][z.xcor - 1])
                neighborsArray.append(zones[z.ycor + 1][z.xcor - 1])
            } else {
                neighborsArray.append(zones[z.ycor][z.xcor - 1])
                neighborsArray.append(zones[z.ycor][z.xcor + 1])
                neighborsArray.append(zones[z.ycor + 1][z.xcor - 1])
                neighborsArray.append(zones[z.ycor + 1][z.xcor + 1])
            }
            
        } else if z.ycor == (height-1) {
            neighborsArray.append(zones[z.ycor - 1][z.xcor])
            if z.xcor == 0 {
                neighborsArray.append(zones[z.ycor - 1][z.xcor + 1])
                neighborsArray.append(zones[z.ycor][z.xcor + 1])
            } else if z.xcor == (width-1) {
                neighborsArray.append(zones[z.ycor - 1][z.xcor - 1])
                neighborsArray.append(zones[z.ycor][z.xcor - 1])
            } else {
                neighborsArray.append(zones[z.ycor - 1][z.xcor - 1])
                neighborsArray.append(zones[z.ycor - 1][z.xcor + 1])
                neighborsArray.append(zones[z.ycor][z.xcor - 1])
                neighborsArray.append(zones[z.ycor][z.xcor + 1])
            }
        } else {
            neighborsArray.append(zones[z.ycor + 1][z.xcor])
            neighborsArray.append(zones[z.ycor - 1][z.xcor])
            if z.xcor == 0 {
                neighborsArray.append(zones[z.ycor - 1][z.xcor + 1])
                neighborsArray.append(zones[z.ycor][z.xcor + 1])
                neighborsArray.append(zones[z.ycor + 1][z.xcor + 1])
            } else if z.xcor == (width-1) {
                neighborsArray.append(zones[z.ycor - 1][z.xcor - 1])
                neighborsArray.append(zones[z.ycor][z.xcor - 1])
                neighborsArray.append(zones[z.ycor + 1][z.xcor - 1])
            } else {
                neighborsArray.append(zones[z.ycor - 1][z.xcor - 1])
                neighborsArray.append(zones[z.ycor - 1][z.xcor + 1])
                neighborsArray.append(zones[z.ycor][z.xcor - 1])
                neighborsArray.append(zones[z.ycor][z.xcor + 1])
                neighborsArray.append(zones[z.ycor + 1][z.xcor - 1])
                neighborsArray.append(zones[z.ycor + 1][z.xcor + 1])
            }
        }
        
        return neighborsArray
    }
    
    func placeNumbers() {
        for i in 0..<height {
            for j in 0..<width {
                var zoneNeighbors = getNeighbors(zones[i][j])
                let len = zoneNeighbors.count
                var zoneNumber = 0
                for k in 0..<len {
                    if zoneNeighbors[k].state {
                        zoneNumber += 1
                    }
                }
                zones[i][j].zoneValue = zoneNumber
            }
        }
    }
    
    func openZone(z: Zone) {
        if(!zones[z.ycor][z.xcor].marked && !zones[z.ycor][z.xcor].revealed){
            zones[z.ycor][z.xcor].revealed = true
            if zones[z.ycor][z.xcor].zoneValue == 0 {
                openNeighbors(zones[z.ycor][z.xcor])
            }
        }
    }
    
    func openNeighbors(z: Zone) {
        var neighbors = getNeighbors(z)
        for i in 0..<neighbors.count {
            if !neighbors[i].revealed {
                openZone(neighbors[i])
            }
        }
    }
    
    func restart() {
        zones = [[Zone]]()
        self.minesLeft = self.numMines
    }

}