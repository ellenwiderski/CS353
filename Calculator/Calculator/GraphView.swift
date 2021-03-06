//
//  GraphView.swift
//  Calculator
//
//  Created by Ellen Widerski on 3/9/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import UIKit

protocol GraphViewDataSource: class {
    func calculatorForGraphView(sender: GraphView) -> CalculatorBrain?
}

@IBDesignable
class GraphView: UIView {
    var drawer = AxesDrawer(color: UIColor.blackColor())
    
    weak var dataSource: GraphViewDataSource?
    
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
        drawGraph()
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
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x:0,y:graphCenter.y))
        let cb = dataSource?.calculatorForGraphView(self) ?? nil
        
        let screenWidth = Int(center.x)*2
        for i in 1...screenWidth {
            if let cb = cb {
                let x = CGFloat(i - screenWidth/2) / scale
                cb.variableValues["M"] = Double(x)
                if let yval = cb.evaluate() {
                    let y = CGFloat(yval)
                    let point = CGPoint(x: CGFloat(x*scale + graphCenter.x), y: CGFloat(-y*scale + graphCenter.y))
                    path.addLineToPoint(point)
                    path.moveToPoint(point)
                }
            }
        }
        path.closePath()
        UIColor.blackColor().setStroke()
        path.stroke()
        setNeedsDisplay()
    }
}
