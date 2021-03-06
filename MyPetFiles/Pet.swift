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
    var breed: [String]
    var name: String
    var sex: String
    var age: String
    var size: String
    var description: String
    var largePhotoURLs = [String: AnyObject]()
    var thumbnailPhotoURLs = [String: AnyObject]()
    var petnotePhotoURLs = [String: AnyObject]()
    
    init(dictionary: [String: AnyObject]) {
        let idArray = dictionary[PetfinderClient.JSONResponseKeys.ID] as! [String: AnyObject]
        id = idArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        let animalArray = dictionary[PetfinderClient.JSONResponseKeys.Animal] as! [String: AnyObject]
        animal = animalArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        breed = [String]()
        let breeds = dictionary[PetfinderClient.JSONResponseKeys.Breeds] as! [String: AnyObject]
        if let breedsArray = breeds[PetfinderClient.JSONResponseKeys.Breed] as? [[String: AnyObject]] {
            for breedArray in breedsArray {
                let b = breedArray[PetfinderClient.JSONResponseKeys.Tag] as! String
                breed.append(b)
            }
        } else if let breedArray = breeds[PetfinderClient.JSONResponseKeys.Breed] as? [String: AnyObject] {
            let b = breedArray[PetfinderClient.JSONResponseKeys.Tag] as! String
            breed.append(b)
        }
        
        let nameArray = dictionary[PetfinderClient.JSONResponseKeys.Name] as! [String: AnyObject]
        name = nameArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        let sexArray = dictionary[PetfinderClient.JSONResponseKeys.Sex] as! [String: AnyObject]
        sex = sexArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        let descArray = dictionary[PetfinderClient.JSONResponseKeys.Description] as! [String: AnyObject]
        if let desc = descArray[PetfinderClient.JSONResponseKeys.Tag] as? String {
            description = desc
        } else {
            description = ""
        }
        
        let ageArray = dictionary[PetfinderClient.JSONResponseKeys.Age] as! [String: AnyObject]
        age =  ageArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        let sizeArray = dictionary[PetfinderClient.JSONResponseKeys.Size] as! [String: AnyObject]
        size = sizeArray[PetfinderClient.JSONResponseKeys.Tag] as! String
        
        let mediaDictionary = dictionary[PetfinderClient.JSONResponseKeys.Media] as! [String: AnyObject]
        if let photosDictionary = mediaDictionary[PetfinderClient.JSONResponseKeys.Photos] as? [String: AnyObject] {
            if let photoDictionaryArray = photosDictionary[PetfinderClient.JSONResponseKeys.Photo] as? [[String: AnyObject]] {
                for photoDictionary in photoDictionaryArray {
                    let photoSize = photoDictionary[PetfinderClient.JSONResponseKeys.PhotoSize] as! String
                    let photoURL = photoDictionary[PetfinderClient.JSONResponseKeys.Tag] as! String
                    let photoID = photoDictionary[PetfinderClient.JSONResponseKeys.PhotoID] as! String
                    
                    switch photoSize {
                    case PetfinderClient.JSONResponseValues.LargePhotoSize:
                        largePhotoURLs[photoID] = photoURL
                    case PetfinderClient.JSONResponseValues.ThumbnailPhotoSize:
                        thumbnailPhotoURLs[photoID] = photoURL
                    case PetfinderClient.JSONResponseValues.PetnotePhotoSize:
                        petnotePhotoURLs[photoID] = photoURL
                    default: break // Ignore other sizes
                    }
                }
            }
        }
    }
    
    
    // MARK: Helper functions
    
    func getBreed() -> String {
        var returnString = ""
        
        if breed.count > 0 {
            returnString = breed.joinWithSeparator(" & ")
            returnString = returnString + " Mix"
        } else {
            returnString = "Breed Unknown"
        }
        
        return returnString
    }
}
