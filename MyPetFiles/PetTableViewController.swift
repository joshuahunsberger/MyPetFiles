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
    
    
    // MARK: View Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let shelter = shelter {
            getPets(shelter.id)
        }
    }
    
    
    // MARK: UI Setup functions
    
    func getPets(shelterID: String) {
        let parameters: [String: AnyObject] = [PetfinderClient.ParameterKeys.ID : shelterID]
        
        PetfinderClient.sharedInstance.getShelterPets(parameters) { (results, error) in
            if (error != nil) {
                // Handle error
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
}
