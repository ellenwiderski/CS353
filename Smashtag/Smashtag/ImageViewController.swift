//
//  ImageViewController.swift
//  Smashtag
//
//  Created by Ellen Widerski on 4/18/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var url: NSURL? = nil
    
    override func viewDidLoad() {
        imageView.image = UIImage(data: NSData(contentsOfURL: url!)!)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
    }
}
