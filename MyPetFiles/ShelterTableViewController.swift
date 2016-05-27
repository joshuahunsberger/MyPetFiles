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
    
    // MARK: View Lifecycle Functions 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loc = location, name = groupName {
            // Set parameters
            var parameters = [String: AnyObject]()
            
            parameters[PetfinderClient.ParameterKeys.Location] = loc
            if (!name.isEmpty) {
                parameters[PetfinderClient.ParameterKeys.Name] = name
            }
            
            PetfinderClient.sharedInstance.searchShelters(parameters) { (results, error) in
                if (error != nil) {
                    // Display error
                    // TODO: Display alert view for error
                    print("\(error!.localizedDescription)")
                } else {
                    let sheltersJSON = results as! [[String: AnyObject]]
                    
                    for shelterJSON in sheltersJSON {
                        let shelter = Shelter(dictionary: shelterJSON)
                        self.shelters.append(shelter)
                    }
                    
                    // Update the table on the main thread
                    dispatch_async(dispatch_get_main_queue()) {
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
        return shelters.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let shelter = shelters[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ShelterCell")!
        cell.textLabel!.text = shelter.name
        cell.detailTextLabel!.text = shelter.getAddress()
        
        return cell
    }
}
