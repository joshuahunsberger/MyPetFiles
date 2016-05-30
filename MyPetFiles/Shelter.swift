//
//  Shelter.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 5/25/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

class Shelter {
    // MARK: Properties
    let id: String!
    let name: String!
    let address1: String!
    let address2: String!
    let city: String!
    let state: String!
    let zip: String!
    let email: String!
    let phone: String!
    
    // MARK: Initialization method
    
    init(dictionary: [String: AnyObject]) {
        let idArray = dictionary[PetfinderClient.JSONResponseKeys.ID] as! [String: AnyObject]
        id = idArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        let nameArray = dictionary[PetfinderClient.JSONResponseKeys.Name] as! [String: AnyObject]
        name = nameArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        let address1Array = dictionary[PetfinderClient.JSONResponseKeys.Address1] as! [String: AnyObject]
        if let addr1 = address1Array[PetfinderClient.JSONResponseKeys.Tag] as? String {
            address1 = addr1
        } else {
            address1 = ""
        }
        
        let address2Array = dictionary[PetfinderClient.JSONResponseKeys.Address2] as! [String: AnyObject]
        if let addr2 = address2Array[PetfinderClient.JSONResponseKeys.Tag] as? String {
            address2 = addr2
        } else {
            address2 = ""
        }
        
        let cityArray = dictionary[PetfinderClient.JSONResponseKeys.City] as! [String: AnyObject]
        city = cityArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        let stateArray = dictionary[PetfinderClient.JSONResponseKeys.State] as! [String: AnyObject]
        state = stateArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        let zipArray = dictionary[PetfinderClient.JSONResponseKeys.Zip] as! [String: AnyObject]
        zip = zipArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        let emailArray = dictionary[PetfinderClient.JSONResponseKeys.Email] as! [String: AnyObject]
        if let em = emailArray[PetfinderClient.JSONResponseKeys.Tag] as? String {
            email = em
        } else {
            email = ""
        }
        
        let phoneArray = dictionary[PetfinderClient.JSONResponseKeys.Phone] as! [String: AnyObject]
        if let ph = phoneArray[PetfinderClient.JSONResponseKeys.Tag] as? String {
            phone = ph
        } else {
            phone = ""
        }
    }
    
    
    // MARK: Helper functions
    
    func getShortAddress() -> String {
        return "\(city), \(state) \(zip)"
    }
    
    func getLongAddress() -> String {
        if (address1.isEmpty) {
            return getShortAddress()
        } else {
            return "\(address1)\n\(getShortAddress())"
        }
    }
    
    func getContactInformation() -> String {
        if (phone.isEmpty && email.isEmpty) {
            return "No contact information available."
        } else if (phone.isEmpty) {
            return "Email: \(email)"
        } else if (email.isEmpty) {
            return "Phone: \(phone)"
        } else {
            return "Email: \(email)\nPhone: \(phone)"
        }
    }
}
