//
//  EntryTableViewController.swift
//  MovileExercicio
//
//  Created by User on 20/06/15.
//  Copyright (c) 2015 User. All rights reserved.
//

import Runes
import Argo
import UIKit
import Foundation

extension NSDate
{
    func isEqualToADate(dateToCompare : NSDate) -> Bool
    {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame
        {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
}

class EntryTableViewController: UITableViewController {

    var ArrayEntries = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var error: NSError?
            
        let path = NSBundle.mainBundle().pathForResource("new-pods", ofType: "json")
        let data: NSData? = NSData(contentsOfFile: path!)
        var parseError: NSError?
        //self.entryDict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error:&parseError) as! NSDictionary
        var error: NSError?
        
        if let json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error:&parseError) as? NSDictionary,
           let responseData = json["responseData"] as? NSDictionary,
           let feed = responseData["feed"] as? NSDictionary,
           let entries = feed["entries"] as? NSArray
        {
            //println(entries)
            for x in entries{
                let entry: Entry? = decode(x) // ignore error info or
                let decodedEntry: Decoded<Entry> = decode(x) // preserve error info
                ArrayEntries.append(entry!)
            }
            //println(ArrayEntries)
            
        }
        
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension
    
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return ArrayEntries.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CellEntry
        
        cell.Normal()
        
        
        let entry = ArrayEntries[indexPath.row]
        let contentSnippet = entry.contentSnippet

        cell.title.text = entry.title
        cell.subtitle.text = split(contentSnippet) { $0 == "\n"}[0]
        
        let cal = NSCalendar.currentCalendar()
    
        if(cal.isDateInToday(entry.publishedDate)) {
            cell.Negrito()
        }
        

        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let entry = ArrayEntries[indexPath.row]
        
        let websiteAddress = entry.link
        UIApplication.sharedApplication().openURL(websiteAddress)
    }

}
