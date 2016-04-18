//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell
{
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    
    func updateUI() {
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        if let tweet = self.tweet
        {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil  {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            
            
                let attributedTweetText = NSMutableAttributedString(string:tweetTextLabel.text!)
                
                let hashtagColor = UIColor(red: 17.0/255.0, green: 190.0/255.0, blue: 247.0/255.0, alpha: 1.0)
                let urlColor = UIColor(red: 161.0/255.0, green: 129.0/255.0, blue: 240.0/255.0, alpha: 1.0)
                let userColor = UIColor(red: 16.0/255.0, green: 232.0/255.0, blue: 135.0/255.0, alpha: 1.0)
                
                for hashtag in tweet.hashtags {
                    attributedTweetText.addAttribute(NSForegroundColorAttributeName, value: hashtagColor , range: hashtag.nsrange)
                }
                
                for url in tweet.urls {
                    attributedTweetText.addAttribute(NSForegroundColorAttributeName, value: urlColor , range: url.nsrange)
                }
                
                for user in tweet.userMentions {
                    attributedTweetText.addAttribute(NSForegroundColorAttributeName, value: userColor , range: user.nsrange)
                }
                
                
                tweetTextLabel?.attributedText = attributedTweetText
            }
            
            
            tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
            
            if let profileImageURL = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOfURL: profileImageURL) { // blocks main thread!
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
            
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            } else {
                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            }
            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
        }

    }
}
