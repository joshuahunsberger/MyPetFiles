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
    
    
    // MARK: Interface Builder Outlet Properties
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var animalTypeTextField: UITextField!
    @IBOutlet weak var breedTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    
    // MARK: View Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
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
        
        // Set initial picker view status to hidden
        pickerParentView.hidden = true
    }
    
    
    // MARK: Bar Button Action Functions
    
    func doneTapped() {
        // Hide picker view
        pickerParentView.hidden = true
    }
    
    func clearTapped() {
        // Hide picker view
        pickerParentView.hidden = true
        // TODO: Clear selected text field
    }
}
