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
        addressLabel.text = shelter.getAddress()
    }
    
    
    // MARK: Interface Builder Action Functions
    
    @IBAction func shelterPageButtonPressed(sender: UIButton) {
        // TODO: Create Petfinder page URL
        // TODO: Open Petfinder URL in Safari
    }
    
}
