//
//  ShelterSearchViewController.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 5/21/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

import UIKit

class ShelterSearchViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var groupNameTextField: UITextField!
    
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
        if locationTextField.text!.isEmpty {
            let errorTitle = "Missing Location"
            let message = "Please enter a location in the top text box."
            let alert = UIAlertController(title: errorTitle, message: message, preferredStyle: .Alert)
            let dismissAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(dismissAction)
            self.presentViewController(alert, animated: false, completion: nil)
        } else {
            // TODO: Initiate search based on text fields
        }
    }
}
