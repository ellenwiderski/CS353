//
//  MentionsTableViewController.swift
//  Smashtag
//
//  Created by Ellen Widerski on 4/5/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class MentionsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        mentions["Hashtags"] = Mention.Hashtag(tweet!.hashtags)
        mentions["Urls"] = Mention.Url(tweet!.urls)
        mentions["Images"] = Mention.Image(tweet!.media)
        mentions["Users"] = Mention.User(tweet!.userMentions)
        
        var index = 0
        
        if (mentions["Hashtags"]?.isInTable) == 1 {
            sections[index] = "Hashtags"
            index += 1
        }
        
        if mentions["Urls"]?.isInTable == 1 {
            sections[index] = "Urls"
            index += 1
        }
        
        if mentions["Images"]?.isInTable == 1 {
            sections[index] = "Images"
            index += 1
        }
        
        if mentions["Users"]?.isInTable == 1 {
            sections[index] = "Users"
            index += 1
        }
        
        
        
    }
    
    var tweet : Tweet? = nil

    // MARK: - Table view data source
    
    private enum Mention {
        case Image([MediaItem])
        case Url([Tweet.IndexedKeyword])
        case Hashtag([Tweet.IndexedKeyword])
        case User([Tweet.IndexedKeyword])
        
        var titleForHeaderInSection : String {
            get {
                switch self {
                case .Image(_):
                    return "Images"
                    
                case .Url(_):
                    return "Urls"
                    
                case .Hashtag(_):
                    return "Hashtags"
                    
                case .User(_):
                    return "Users"
                }
            }
        }
        
        var numberOfRowsInSection : Int {
            get {
                switch self {
                case .Image(let images):
                    return images.count
                    
                case .Url(let urls):
                    return urls.count
                    
                case .Hashtag(let hashtags):
                    return hashtags.count
                    
                case .User(let users):
                    return users.count
                }
            }
        }
        
        var isInTable : Int {
            get {
                if numberOfRowsInSection == 0 {
                    return 0
                }
                return 1
            }
        }
        
        var content : [String] {
            get {
                switch self {
                case .Image(let images):
                    return images.map {String($0.url)}
                
                case .Url(let urls):
                    return urls.map {String($0.keyword)}
                
                case .Hashtag(let hashtags):
                    return hashtags.map {String($0.keyword)}
                
                case .User(let users):
                    return users.map {String($0.keyword)}
                }
            }
        }
        
        var aspectRatio : [Double]? {
            get {
                switch self {
                case .Image(let images):
                    return images.map {$0.aspectRatio}
                default:
                    return nil
                }
            }
        }
    }
    
    private var mentions = [String: Mention]()
    private var sections = [Int: String]()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numRows = (mentions["Hashtags"]?.isInTable)! + (mentions["Urls"]?.isInTable)! + (mentions["Images"]?.isInTable)! + (mentions["Users"]?.isInTable)!
        return numRows
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (mentions[sections[section]!]?.numberOfRowsInSection)!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(sections[indexPath.section]!, forIndexPath: indexPath) as! MentionsTableViewCell
        
        cell.content = mentions[sections[indexPath.section]!]!.content[indexPath.row]
        
        cell.section = sections[indexPath.section]
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mentions[sections[section]!]!.titleForHeaderInSection
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if sections[indexPath.section] == "Images" {
            return CGFloat(mentions["Images"]!.aspectRatio![indexPath.row])*tableView.bounds.size.width
        }
        else {
            return UITableViewAutomaticDimension
        }
    }
 
    @IBAction func urlTap(sender: UITapGestureRecognizer) {
        if let mentionCell = sender.view as? MentionsTableViewCell {
            let url = NSURL(string: mentionCell.content!)
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var destination =  segue.destinationViewController as UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let ttvc = destination as? TweetTableViewController {
            if let mentionCell = sender as? MentionsTableViewCell {
                ttvc.searchText = mentionCell.content
            }
        }
        else if let ivc = destination as? ImageViewController {
            if let mentionCell = sender as? MentionsTableViewCell {
                ivc.url = NSURL(string: mentionCell.content!)
            }
        }
    }
}
