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
    
    // MARK: URL constants
    
    struct Constants {
        static let APIScheme = "http"
        static let APIHost = "api.petfinder.com"
    }
    
    
    // MARK: API Method Constants
    
    struct Methods {
        static let BreedList = "/breed.list"
        static let GetPet = "/pet.get"
        static let FindPet = "/pet.find"
        static let FindShelter = "/shelter.find"
        static let GetShelter = "/shelter.get"
        static let GetShelterPets = "/shelter.getPets"
        static let ShelterListByBreed = "/shelter.listByBreed"
    }
    
    
    // MARK: Parameter Keys
    
    struct ParameterKeys {
        static let APIKey = "key"
        static let SessionToken = "token"
        static let Location = "location"
        static let Name = "name"
        static let ResultOffset = "offset"
        static let RecordCount = "count"
        static let ResultFormat = "format"
        static let Animal = "animal"
        static let Breed = "breed"
        static let Size = "size"
        static let Sex = "sex"
        static let Age = "age"
        static let Output = "output"
        static let ID = "id"
    }
    
    
    // MARK: Parameter Values
    
    struct ParameterValues {
        static let APIKey = "565238d1f77d40730ae9613e455a30d0" /* Specify your API Key here. */
        static let JSONFormat = "json"
    }
    
    
    // MARK: JSON Response Keys
    
    struct JSONResponseKeys {
        static let Petfinder = "petfinder"
        static let Shelters = "shelters"
        static let Shelter = "shelter"
        static let Pets = "pets"
        static let Pet = "pet"
        static let Breeds = "breeds"
        static let Breed = "breed"
    }
}