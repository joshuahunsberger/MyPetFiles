//
//  PetTableViewController.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 6/1/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

import UIKit

class PetTableViewController: UITableViewController {
    // MARK: Properties
    var shelter: Shelter?
    var pets = [Pet]()
    var emptyMessageLabel: UILabel!
    
    
    // MARK: View Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let shelter = shelter {
            getPets(shelter.id)
        }
        
        addEmptyMessageLabel()
    }
    
    
    // MARK: UI Setup functions
    
    func getPets(shelterID: String) {
        let parameters: [String: AnyObject] = [PetfinderClient.ParameterKeys.ID : shelterID]
        
        PetfinderClient.sharedInstance.getShelterPets(parameters) { (results, error) in
            if (error != nil) {
                // Display error in alert view
                let errorTitle = "Error"
                let message = error!.localizedDescription
                let alert = UIAlertController(title: errorTitle, message: message, preferredStyle: .Alert)
                let dismissAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                alert.addAction(dismissAction)
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(alert, animated: false, completion: nil)
                }
            } else {
                let petsJSON = results as! [[String: AnyObject]]
                
                for petJSON in petsJSON {
                    let pet = Pet(dictionary: petJSON)
                    self.pets.append(pet)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func addEmptyMessageLabel() {
        emptyMessageLabel = UILabel(frame: CGRectMake(0,0,tableView.bounds.size.width,tableView.bounds.size.height))
        emptyMessageLabel.text = "No pets found."
        emptyMessageLabel.textAlignment = NSTextAlignment.Center
        emptyMessageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        emptyMessageLabel.sizeToFit()
        tableView.backgroundView = emptyMessageLabel
    }
    
    
    // MARK: Table View Functions
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(pets.count == 0) {
            emptyMessageLabel.hidden = false
        } else {
            emptyMessageLabel.hidden = true
        }
        return pets.count
    }
}
