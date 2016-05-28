//
//  Shelter.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 5/25/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

class Shelter {
    let id: String!
    let name: String!
    let address1: String!
    let address2: String!
    let city: String!
    let state: String!
    let zip: String!
    
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
    }
    
    func getAddress() -> String {
        return "\(city), \(state) \(zip)"
    }
}
