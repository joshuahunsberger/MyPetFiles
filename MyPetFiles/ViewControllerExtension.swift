//
//  ViewControllerExtension.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 6/18/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

import UIKit

/**
    Extend UIViewController to dismiss keyboard when the user taps on the screen away from the keyboard
    Code from StackOverflow user Esqarrouth here: http://stackoverflow.com/a/27079103
 */

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
