//
//  PetfinderConstants.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 5/15/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

import Foundation

extension PetfinderClient {
    
    struct Constants {
        static let APIScheme = "http"
        static let APIHost = "api.petfinder.com"
    }
    
    
    // MARK: API Method Constants
    
    struct Methods {
        static let BreedList = "breed.list"
        static let GetPet = "pet.get"
        static let FindPet = "pet.find"
        static let FindShelter = "shelter.find"
        static let GetShelter = "shelter.get"
        static let GetShelterPets = "shelter.getPets"
        static let ShelterListByBreed = "shelter.listByBreed"
    }
    
}