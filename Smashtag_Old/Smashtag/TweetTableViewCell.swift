//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Ellen Widerski on 4/4/16.
//  Copyright © 2016 Ellen Widerski. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    func updateUI() {
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.attributedText = nil
        tweetProfileImageView?.image = nil
//        tweetCreatedLabel?.text = nil
        
        // load new information from out tweet (if any)
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += "  📷"
                }
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)" //tweet.user.description
            
            if let profileImageURL = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOfURL: profileImageURL) { //blocks main thread
                    tweetProfileImageView?.image = UIImage(date: imageData)
                }
            }
            
//            let formatter = NSDateFormatter()
//            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
//                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
//            }
//            else {
//                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
//            }
//            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)

        }
    }

}
 