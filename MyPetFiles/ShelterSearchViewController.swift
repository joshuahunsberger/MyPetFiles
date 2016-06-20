//
//  ShelterSearchViewController.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 5/21/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

import UIKit

class ShelterSearchViewController: UIViewController {
    // MARK: Properties
    var selectedTextField: UITextField?
    // MARK: Interface Builder Outlet Properties
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    // MARK: View Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTextField.delegate = self
        groupNameTextField.delegate = self
        
        hideKeyboardWhenTappedAround()
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    
    // MARK: Keyboard Notification Setup Functions
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWasShown), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification) {
        guard let textField = selectedTextField else {
            // No text field selected. Return
            return
        }
        
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
                scrollView.contentInset = contentInsets
                scrollView.scrollIndicatorInsets = contentInsets
                
                var aRect: CGRect = view.frame
                aRect.size.height -= keyboardSize.height
                if(!CGRectContainsPoint(aRect, textField.frame.origin)) {
                    scrollView.scrollRectToVisible(textField.frame, animated: true)
                }
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        resetScrollView()
    }
    
    func resetScrollView() {
        // Scroll scrollview back to bottom
        let contentInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
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

extension ShelterSearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        selectedTextField = textField
    }
    
    // Dismiss keyboard when return is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
