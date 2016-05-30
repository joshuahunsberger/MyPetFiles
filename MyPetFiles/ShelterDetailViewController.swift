//
//  ShelterDetailViewController.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 5/26/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

import UIKit

class ShelterDetailViewController: UIViewController {
    // MARK: Properties
    var shelter: Shelter!
    
    
    // MARK: Interface Builder Outlet Properties
    @IBOutlet weak var shelterNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!

    
    // MARK: View Lifecycle Functions
    
    override func viewDidLoad() {
        shelterNameLabel.text = shelter.name
        addressLabel.text = "Address\n\(shelter.getLongAddress())"
        contactLabel.text = "Contact\n\(shelter.getContactInformation())"
    }
    
    
    // MARK: Interface Builder Action Functions
    
    @IBAction func shelterPageButtonPressed(sender: UIButton) {
        // Create Petfinder page URL
        let url = PetfinderClient.sharedInstance.getShelterURL(shelter.id)
        
        // Open Petfinder URL in Safari
        let app = UIApplication.sharedApplication()
        if (app.canOpenURL(url)) {
            app.openURL(url)
        } else {
            print("There was an error opening the Petfinder page.")
        }
    }
    
}
