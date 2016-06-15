//
//  PetSearchViewController.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 6/12/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

import UIKit

class PetSearchViewController: UIViewController {
    // MARK: Constants
    let PICKER_VIEW_HEIGHT: CGFloat = 216
    let TOOLBAR_HEIGHT: CGFloat = 44
    
    
    // MARK: Properties
    let pickerParentView: UIView = UIView()
    let pickerView: UIPickerView = UIPickerView()
    let pickerToolbar: UIToolbar = UIToolbar()
    // TODO: Track currently selected text field
    var selectedTextField: UITextField?
    
    // MARK: Interface Builder Outlet Properties
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var animalTypeTextField: UITextField!
    @IBOutlet weak var breedTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    // MARK: View Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTextField.delegate = self
        animalTypeTextField.delegate = self
        breedTextField.delegate = self
        ageTextField.delegate = self
        genderTextField.delegate = self
        
        setupPickerView()
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    
    // MARK: UI Setup Functions
    
    func setupPickerView() {
        let frameWidth = view.frame.width
        let frameHeight = view.frame.height
        
        // Define view frames
        pickerParentView.frame = CGRectMake(0, frameHeight-PICKER_VIEW_HEIGHT, frameWidth, PICKER_VIEW_HEIGHT)
        pickerToolbar.frame = CGRectMake(0, 0, frameWidth, TOOLBAR_HEIGHT)
        pickerView.frame = CGRectMake(0, pickerToolbar.frame.maxY, frameWidth, PICKER_VIEW_HEIGHT-TOOLBAR_HEIGHT)
        
        // Add buttons to tolbar
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(PetSearchViewController.doneTapped))
        let clearButton: UIBarButtonItem = UIBarButtonItem(title: "Clear", style: .Plain, target: self, action: #selector(PetSearchViewController.clearTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        pickerToolbar.items = [clearButton, flexibleSpace, doneButton]
        
        // Add picker and toolbar to parent view
        pickerParentView.addSubview(pickerToolbar)
        pickerParentView.addSubview(pickerView)
        
        // Add parent view to larger view
        view.addSubview(pickerParentView)
        
        // Set background of picker view
        pickerParentView.backgroundColor = UIColor.whiteColor()
        
        // Set initial picker view status to hidden
        pickerParentView.hidden = true
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
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
        let contentInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    // MARK: Bar Button Action Functions
    
    func doneTapped() {
        // Hide picker view
        pickerParentView.hidden = true
        selectedTextField = nil
    }
    
    func clearTapped() {
        // Hide picker view
        pickerParentView.hidden = true
        // TODO: Clear selected text field
        selectedTextField = nil
    }
}

extension PetSearchViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        selectedTextField = textField
        if (textField == animalTypeTextField || textField == genderTextField) {
            pickerView.reloadAllComponents()
            pickerParentView.hidden = false
            return false
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        selectedTextField = nil
        return true
    }
}

extension PetSearchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let textField = selectedTextField else {
            return 0
        }
        
        if (textField == animalTypeTextField) {
            return PetfinderClient.AnimalTypeDisplayNames.count + 1
        } else if (textField == genderTextField) {
            return PetfinderClient.AnimalGenderDisplayNames.count + 1
        } else {
            print("Undefined textfield for pickerview. Returning 0 rows")
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let textField = selectedTextField else {
            return ""
        }
        
        if (row == 0) {
            return "Select an option"
        } else if (textField == animalTypeTextField) {
            return PetfinderClient.AnimalTypeDisplayNames[row-1]
        } else if (textField == genderTextField) {
            return PetfinderClient.AnimalGenderDisplayNames[row-1]
        } else {
            print("Undefined textfield for pickerview. Returning blank text.")
            return ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let textField = selectedTextField else {
            return
        }
        
        if (textField == animalTypeTextField) {
            if (row == 0) {
                animalTypeTextField.text = ""
            } else {
                animalTypeTextField.text = PetfinderClient.AnimalTypeDisplayNames[row-1]
            }
        } else if (textField == genderTextField) {
            if (row == 0) {
                genderTextField.text = ""
            } else {
                genderTextField.text = PetfinderClient.AnimalGenderDisplayNames[row-1]
            }
        }
    }
}
