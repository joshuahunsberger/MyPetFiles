//
//  Pet.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 6/2/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

class Pet {
    var id: String
    var animal: String
    var breed: String
    var name: String
    var sex: String
    var age: String
    var size: String
    var description: String
    
    
    init(dictionary: [String: AnyObject]) {
        id = dictionary[PetfinderClient.JSONResponseKeys.ID] as! String
        animal = dictionary[PetfinderClient.JSONResponseKeys.Animal] as! String
        breed = dictionary[PetfinderClient.JSONResponseKeys.Breed] as! String
        name = dictionary[PetfinderClient.JSONResponseKeys.Name] as! String
        sex = dictionary[PetfinderClient.JSONResponseKeys.Sex] as! String
        if let desc = dictionary[PetfinderClient.JSONResponseKeys.Description] as? String {
            description = desc
        } else {
            description = ""
        }
        age = dictionary[PetfinderClient.JSONResponseKeys.Age] as! String
        size = dictionary[PetfinderClient.JSONResponseKeys.Size] as! String
    }
}
