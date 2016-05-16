//
//  PetfinderConstants.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 5/15/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

/**
    Extension to Petfinder client that stores structs representing the constant values associated with the
    Petfinder API.
 
    The Petfinder API is documented here: https://www.petfinder.com/developers/api-docs
 */

// MARK: PetfinderClient (Constants)

extension PetfinderClient {
    
    //MARK: URL constants
    
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