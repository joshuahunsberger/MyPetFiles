//
//  ShelterTableViewController.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 5/22/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

import UIKit

class ShelterTableViewController: UITableViewController {
    // MARK: Properties
    var location: String!
    var groupName: String?
    var shelters = [Shelter]()
    var emptyMessageLabel: UILabel!
    let resultCount = 25
    var offset = 0
    var hasMore: Bool = true
    
    
    // MARK: View Lifecycle Functions 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchPetFinder()
        
        addEmptyMessageLabel()
    }
    
    
    // MARK: UI setup functions
    
    func addEmptyMessageLabel() {
        emptyMessageLabel = UILabel(frame: CGRectMake(0,0,tableView.bounds.size.width,tableView.bounds.size.height))
        emptyMessageLabel.text = "No shelters found."
        emptyMessageLabel.textAlignment = NSTextAlignment.Center
        emptyMessageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        emptyMessageLabel.sizeToFit()
        tableView.backgroundView = emptyMessageLabel
    }
    
    
    // MARK: Helper functions
    
    func searchPetFinder() {
        if let loc = location, name = groupName {
            // Set parameters
            var parameters = [String: AnyObject]()
            
            parameters[PetfinderClient.ParameterKeys.Location] = loc
            if (!name.isEmpty) {
                parameters[PetfinderClient.ParameterKeys.Name] = name
            }
            parameters[PetfinderClient.ParameterKeys.RecordCount] = resultCount
            parameters[PetfinderClient.ParameterKeys.ResultOffset] = offset
            
            // Display activity indicator while loading
            let activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
            activityIndicator.activityIndicatorViewStyle = .WhiteLarge
            view.addSubview(activityIndicator)
            activityIndicator.frame = view.frame
            activityIndicator.center = view.center
            activityIndicator.layer.backgroundColor = UIColor.grayColor().CGColor
            activityIndicator.startAnimating()
            
            PetfinderClient.sharedInstance.searchShelters(parameters) { (results, lastOffset, error) in
                if (error != nil) {
                    // Display error in alert view
                    let errorTitle = "Error"
                    let message = error!.localizedDescription
                    let alert = UIAlertController(title: errorTitle, message: message, preferredStyle: .Alert)
                    let dismissAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                    alert.addAction(dismissAction)
                    dispatch_async(dispatch_get_main_queue()) {
                        activityIndicator.stopAnimating()
                        activityIndicator.removeFromSuperview()
                        self.presentViewController(alert, animated: false, completion: nil)
                    }
                } else {
                    if (lastOffset < (self.offset + self.resultCount) && lastOffset < PetfinderClient.Constants.MaxSearchResults) {
                        self.hasMore = false
                    }
                    self.offset = lastOffset
                    
                    let sheltersJSON = results as! [[String: AnyObject]]
                    
                    for shelterJSON in sheltersJSON {
                        let shelter = Shelter(dictionary: shelterJSON)
                        self.shelters.append(shelter)
                    }
                    
                    // Update the table on the main thread
                    dispatch_async(dispatch_get_main_queue()) {
                        activityIndicator.stopAnimating()
                        activityIndicator.removeFromSuperview()
                        self.tableView.reloadData()
                    }
                }
            }
        } else {
            // Search parameters were not set
        }
    }
    
    
    // MARK: Table View Functions
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (shelters.count == 0) {
            emptyMessageLabel.hidden = false
        } else {
            emptyMessageLabel.hidden = true
        }
        return shelters.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let shelter = shelters[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ShelterCell")!
        cell.textLabel!.text = shelter.name
        cell.detailTextLabel!.text = shelter.getShortAddress()
        
        if (indexPath.row == shelters.count - 1) {
            if (hasMore) {
                searchPetFinder()
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let shelter = shelters[indexPath.row]
        
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("ShelterDetailViewController") as! ShelterDetailViewController
        detailVC.shelter = shelter
        
        navigationController!.pushViewController(detailVC, animated: true)
    }
}
