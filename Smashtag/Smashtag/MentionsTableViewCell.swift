//
//  MentionsTableViewCell.swift
//  Smashtag
//
//  Created by Ellen Widerski on 4/7/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class MentionsTableViewCell: UITableViewCell {

    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    var content: String? = nil {
        didSet {
            if section != nil {
                updateUI()
            }
        }
    }

    var section: String? = nil {
        didSet {
            if content != nil {
                updateUI()
            }
        }
    }
    
    func updateUI() {
        if section == "Hashtags" {
            hashtagLabel.text = nil
            hashtagLabel.text = content!
        }
        else if section == "Images" {
            contentImageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: content!)!)!)
            contentImageView.contentMode = UIViewContentMode.ScaleAspectFit
        }
        else if section == "Urls" {
            urlLabel.text = nil
            urlLabel.text = content!
        }
        else if section == "Users" {
            userLabel.text = nil
            userLabel.text = content!
        }
    }

}
