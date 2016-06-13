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
    }
}
