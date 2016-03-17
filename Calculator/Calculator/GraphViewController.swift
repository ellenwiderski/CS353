//
//  GraphViewController.swift
//  Calculator
//
//  Created by Ellen Widerski on 3/9/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController, GraphViewDataSource {
   
    @IBOutlet weak var functionLabel: UINavigationItem!
    
    @IBOutlet weak var graphview: GraphView! {
        didSet {
            // Pinch
            graphview.addGestureRecognizer(UIPinchGestureRecognizer(target: graphview, action: "zoom:"))
            
            // Pan
            graphview.addGestureRecognizer(UIPanGestureRecognizer(target: graphview, action: "moveGraph:"))
            
            // Double Tap
            let doubleTap = UITapGestureRecognizer(target: graphview, action: "newCenter:")
            doubleTap.numberOfTapsRequired = 2
            graphview.addGestureRecognizer(doubleTap)
            
            graphview.dataSource = self
            
            funcValue = cb?.description ?? ""
        }
    }
    
    var cb: CalculatorBrain? = nil
    
    func calculatorForGraphView(sender: GraphView) -> CalculatorBrain? {
        return cb
    }
    
    var funcValue: String {
        get {
            return functionLabel.title!
        }
        set {
            functionLabel.title = "f(x) = \(newValue) "
        }
    }
    
}