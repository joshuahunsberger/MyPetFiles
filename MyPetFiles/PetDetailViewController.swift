//
//  PetDetailViewController.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 6/4/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

import UIKit

class PetDetailViewController: UIViewController {
    // MARK: Properties
    var pet: Pet!
    
    
    // MARK: Interface Builder Outlet Properties
    
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var photoScrollView: UIScrollView!
    
    
    // MARK: View Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        petNameLabel.text = pet.name
    }
}
