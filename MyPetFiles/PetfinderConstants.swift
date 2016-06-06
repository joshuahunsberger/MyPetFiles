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
        static let APIScheme = "https"
        static let APIHost = "api.petfinder.com"
        static let WWWHost = "www.petfinder.com"
        static let SheltersDirectory = "/shelters/"
        static let ShelterPageExtension = ".html"
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
        static let Header = "header"
        static let Status = "status"
        static let Code = "code"
        static let Message = "message"
        
        static let Petfinder = "petfinder"
        static let Shelters = "shelters"
        static let Shelter = "shelter"
        static let Pets = "pets"
        static let Pet = "pet"
        static let Breeds = "breeds"
        static let Breed = "breed"
        
        static let ID = "id"
        static let Name = "name"
        static let City = "city"
        static let State = "state"
        static let Country = "country"
        static let Zip = "zip"
        static let Phone = "phone"
        static let Email = "email"
        static let Address1 = "address1"
        static let Address2 = "address2"
        
        static let Animal = "animal"
        static let Sex = "sex"
        static let Description = "description"
        static let Age = "age"
        static let Size = "size"
        static let Media = "media"
        static let Photos = "photos"
        static let Photo = "photo"
        
        static let PhotoSize = "@size"
        static let PhotoID = "@id"
        
        static let Tag = "$t"
    }
    
    
    // MARK: JSON Response Values
    
    struct JSONResponseValues {
        static let SuccessStatus = 100
        static let LargePhotoSize = "x"
        static let ThumbnailPhotoSize = "t"
        static let PetnotePhotoSize = "pn"
    }
}