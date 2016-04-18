//
//  BezierPathsView.swift
//  Dropit
//
//  Created by Ellen Widerski on 4/11/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import UIKit

class BezierPathsView: UIView {
    private var bezierPaths = [String:UIBezierPath]()
    
    func setPath(path: UIBezierPath?, named name: String) {
        bezierPaths[name] = path
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        for (_, path) in bezierPaths {
            path.stroke()
        }
    }
}
