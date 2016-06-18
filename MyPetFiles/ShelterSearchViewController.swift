//
//  ShelterSearchViewController.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 5/21/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

import UIKit

class ShelterSearchViewController: UIViewController {
    // MARK: Interface Builder Outlet Properties
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var groupNameTextField: UITextField!
    
    
    // MARK: View Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
    
    
    // MARK: Interface Builder Action Functions
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
        if locationTextField.text!.isEmpty {
            let errorTitle = "Missing Location"
            let message = "Please enter a location in the top text box."
            let alert = UIAlertController(title: errorTitle, message: message, preferredStyle: .Alert)
            let dismissAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(dismissAction)
            self.presentViewController(alert, animated: false, completion: nil)
        } else {
            let location = locationTextField.text!
            let groupName = groupNameTextField.text!
            
            let shelterVC = storyboard?.instantiateViewControllerWithIdentifier("ShelterTableViewController") as! ShelterTableViewController
            
            shelterVC.location = location
            shelterVC.groupName = groupName
            
            self.navigationController!.pushViewController(shelterVC, animated: true)
        }
    }
}
