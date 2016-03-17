//
//  GraphView.swift
//  Calculator
//
//  Created by Ellen Widerski on 3/9/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {
    var drawer = AxesDrawer(color: UIColor.blackColor())
    
    @IBInspectable
    var translation: CGPoint = CGPoint(x: 0.0, y: 0.0) { didSet { setNeedsDisplay() } }
    
    var graphCenter: CGPoint {
        if translation == CGPoint(x: 0.0, y: 0.0) {
            return convertPoint(center, fromView: superview)
        }
        else {
            return CGPoint(x: center.x + translation.x, y: center.y + translation.y)
        }
    }
    
    @IBInspectable
    var scale: CGFloat = 30 { didSet { setNeedsDisplay() } }
    
    override func drawRect(rect: CGRect) {
        drawer.drawAxesInRect(rect, origin: graphCenter, pointsPerUnit: scale)
    }
    
    func zoom(gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            scale *= gesture.scale
            gesture.scale = 1
        default: break
        }
    }
    
    func moveGraph(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case.Changed:
            let pan = gesture.translationInView(self)
            translation.x += pan.x
            translation.y += pan.y
            gesture.setTranslation(CGPointZero, inView: self)
        default: break
        }
    }
    
    func newCenter(gesture: UITapGestureRecognizer) {
        if gesture.state == .Ended {
            let taploc = gesture.locationInView(superview)
            let newGraphCenter: CGPoint = CGPoint(x: taploc.x - center.x, y: taploc.y - center.y)
            translation.x -= newGraphCenter.x
            translation.y -= newGraphCenter.y
        }
    }
    
    func drawGraph() {
        var path = UIBezierPath()
        path.moveToPoint(graphCenter)
        path.addLineToPoint(CGPoint(x:5,y:5))
        path.addLineToPoint(CGPoint(x:200,y:200))
        path.closePath()
        UIColor.blackColor().setStroke()
        path.stroke()
        setNeedsDisplay()
    }
}
