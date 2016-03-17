//
//  ViewController.swift
//  Autolayout
//
//  Created by Ellen Widerski on 3/14/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var secure: Bool = false { didSet { updateUI() } }
    var loggedInUser: User? { didSet { updateUI() } }
    var aspectRatioConstraint: NSLayoutConstraint? {
        willSet {
            if let existingConstraint = aspectRatioConstraint {
                view.removeConstraint(existingConstraint)
            }
        }
        didSet {
            if let newConstraint = aspectRatioConstraint {
                view.addConstraint(newConstraint)
            }
        }
    }
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            if let constrainedView =  imageView {
                if let  newImage = newValue {
                    aspectRatioConstraint =  NSLayoutConstraint(
                        item: constrainedView,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: constrainedView,
                        attribute: .Height ,
                        multiplier: newImage.aspectRatio,
                        constant: 0)
                }
                else {
                    aspectRatioConstraint = nil
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secured Password" : "Password"
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
        image = loggedInUser?.image
        
    }
    @IBAction func login() {
        loggedInUser = User.login(loginField.text ?? "", password: passwordField.text ?? "")
    }
    
    @IBAction func toggleSecurity() {
        secure = !secure
    }
}

extension User {
    var image: UIImage? {
        if let image = UIImage(named: login) {
            return image
        }
        else {
            return UIImage(named: "unknownuser")
        }
    }
}

extension UIImage {
    var aspectRatio: CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}