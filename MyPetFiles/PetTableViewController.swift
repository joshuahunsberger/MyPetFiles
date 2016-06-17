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
    let activityIndicator = UIActivityIndicatorView()
    
    
    // MARK: View Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.frame = CGRectMake(0,0,50,50)
        
        if let shelter = shelter {
            getPets(shelter.id)
        }
        
        addEmptyMessageLabel()
    }
    
    
    // MARK: UI Setup functions
    
    func getPets(shelterID: String) {
        let parameters: [String: AnyObject] = [PetfinderClient.ParameterKeys.ID : shelterID]
        
        addAndShowActivityIndicator()
        
        PetfinderClient.sharedInstance.getShelterPets(parameters) { (results, error) in
            if (error != nil) {
                // Display error in alert view
                let errorTitle = "Error"
                let message = error!.localizedDescription
                let alert = UIAlertController(title: errorTitle, message: message, preferredStyle: .Alert)
                let dismissAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                alert.addAction(dismissAction)
                dispatch_async(dispatch_get_main_queue()) {
                    self.stopAndRemoveActivityIndicator()
                    self.presentViewController(alert, animated: false, completion: nil)
                }
            } else {
                let petsJSON = results as! [[String: AnyObject]]
                
                for petJSON in petsJSON {
                    let pet = Pet(dictionary: petJSON)
                    self.pets.append(pet)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.stopAndRemoveActivityIndicator()
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
    
    func addAndShowActivityIndicator() {
        // Display activity indicator while loading
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.frame
        activityIndicator.center = view.center
        activityIndicator.layer.backgroundColor = UIColor.grayColor().CGColor
        activityIndicator.startAnimating()
    }
    
    func stopAndRemoveActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let pet = pets[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PetCell")!
        cell.textLabel!.text = pet.name
        cell.detailTextLabel!.text = pet.animal + " - " + pet.getBreed()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let pet = pets[indexPath.row]
        
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("PetDetailViewController") as! PetDetailViewController
        detailVC.pet = pet
        
        navigationController!.pushViewController(detailVC, animated: true)
    }
}
