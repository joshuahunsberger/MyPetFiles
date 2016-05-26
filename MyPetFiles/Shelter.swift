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
    let city: String!
    let state: String!
    let zip: String!
    
    init(dictionary: [String: AnyObject]) {
        let idArray = dictionary[PetfinderClient.JSONResponseKeys.Zip] as! [String: AnyObject]
        id = idArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        let nameArray = dictionary[PetfinderClient.JSONResponseKeys.Name] as! [String: AnyObject]
        name = nameArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        let cityArray = dictionary[PetfinderClient.JSONResponseKeys.City] as! [String: AnyObject]
        city = cityArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        let stateArray = dictionary[PetfinderClient.JSONResponseKeys.State] as! [String: AnyObject]
        state = stateArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        let zipArray = dictionary[PetfinderClient.JSONResponseKeys.Zip] as! [String: AnyObject]
        zip = zipArray[PetfinderClient.JSONResponseKeys.Tag] as! String
    }
}
