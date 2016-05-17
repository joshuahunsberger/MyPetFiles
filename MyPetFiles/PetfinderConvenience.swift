//
//  PetfinderConvenience.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 5/16/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

import Foundation

extension PetfinderClient {
    
    /**
        Function to search the Petfinder for shelters given a set of parameters
        
        API Parameters and properties in ParameterKeys struct:
     
        Required:
        - Developer Key: your developer key
            - APIKey
        - Location: the ZIP/postal code or city and state where the search should begin
            - Location
        
        Optional:
        - Token: session token
            - SessionToken
        - Name: full or partial shelter name
            - Name
        - Offset: offset into the result set (default is 0)
            - ResultOffset
        - Count: how many records to return for this particular API call (default is 25)
            - RecordCount
        - Format: Response format: xml, json
            - ResultFormat
     
        - Parameters:
            - parameters: The key value pairs to send to Petfinder.
            - completionHandlerForSearchShelters: The completion handler in which the results will be handled or errors processed.
     */
    func searchShelters(parameters: [String: AnyObject], completionHandlerForSearchShelters: (results: AnyObject!, error: NSError?) -> Void) {
        func sendError(error: String){
            let userInfo = [NSLocalizedDescriptionKey: error]
            completionHandlerForSearchShelters(results: nil, error: NSError(domain: "searchShelters", code: 1, userInfo: userInfo))
        }
        
        taskForGETMethod(Methods.FindShelter, parameters: parameters) { (result, error) in
            guard (error == nil) else {
                sendError(error!.localizedDescription)
                return
            }
            
            guard let petfinder = result[JSONResponseKeys.Petfinder] as? [String: AnyObject] else {
                sendError("Unable to retrieve petfinder key.")
                return
            }
            
            guard let shelters = petfinder[JSONResponseKeys.Shelters] as? [String: AnyObject] else {
                sendError("Unable to retrieve shelters key.")
                return
            }
            
            guard let shelterArray = shelters[JSONResponseKeys.Shelter] as? [[String: AnyObject]] else {
                sendError("Unable to retrieve shelter array.")
                return
            }
            
            if shelterArray.count == 0 {
                sendError("No shelters found. Try a different search.")
                return
            }
            
            // Call the completion handler with the array of shelter JSON entries
            completionHandlerForSearchShelters(results: shelterArray, error: nil)
        }
    }
    
    /**
     Function to search the Petfinder for adoptable pets given a set of parameters
     
     API Parameters and properties in ParameterKeys struct:
     
     Required:
     - Developer Key: your developer key
        - APIKey
     - Location: the ZIP/postal code or city and state where the search should begin
        - Location
     
     Optional:
     - Token: session token
        - SessionToken
     - Animal: type of animal (barnyard, bird, cat, dog, horse, pig, reptile, smallfurry)
        - Animal
     - Breed: breed of animal (use breed.list for a list of valid breeds)
        - Breed
     - Size: size of animal (S=small, M=medium, L=large, XL=extra-large)
        - Size
     - Sex: M=male, F=female
        - Sex
     - Age: age of the animal (Baby, Young, Adult, Senior)
        - Age
     - Offset: offset into the result set (default is 0)
        - ResultOffset
     - Count: how many records to return for this particular API call (default is 25)
        - RecordCount
     - Output: How much of each record to return: basic (no description) or full (includes description)
        - Output
     - Format: Response format: xml, json
        - ResultFormat
     
     - Parameters:
        - parameters: The key value pairs to send to Petfinder.
        - completionHandlerForSearchPets: The completion handler in which the results will be handled or errors processed.
     */
    func searchPets(parameters: [String: AnyObject], completionHandlerForSearchPets: (results: AnyObject!, error: NSError?) -> Void) {
        func sendError(error: String){
            let userInfo = [NSLocalizedDescriptionKey: error]
            completionHandlerForSearchPets(results: nil, error: NSError(domain: "searchShelters", code: 1, userInfo: userInfo))
        }
        
        taskForGETMethod(Methods.FindShelter, parameters: parameters) { (result, error) in
            guard (error == nil) else {
                sendError(error!.localizedDescription)
                return
            }
            
            guard let petfinder = result[JSONResponseKeys.Petfinder] as? [String: AnyObject] else {
                sendError("Unable to retrieve petfinder key.")
                return
            }
            
            guard let pets = petfinder[JSONResponseKeys.Pets] as? [String: AnyObject] else {
                sendError("Unable to retrieve pets key.")
                return
            }
            
            guard let petsArray = pets[JSONResponseKeys.Pet] as? [[String: AnyObject]] else {
                sendError("Unable to retrieve pet array.")
                return
            }
            
            if petsArray.count == 0 {
                sendError("No pets found. Try a different search.")
                return
            }
            
            // Call the completion handler with the array of pet JSON entries
            completionHandlerForSearchPets(results: petsArray, error: nil)
        }
    }
    
    /**
     Function to retrieve a shelter by ID from the Petfinder
     
     API Parameters and properties in ParameterKeys struct:
     
     Required:
     - Developer Key: your developer key
        - APIKey
     - ID: shelter ID (e.g. NJ94)
        - ID
     
     Optional:
     - Token: Session token
        - SessionToken
     - Format: Response format: xml, json
        - ResultFormat
     
     - Parameters:
        - parameters: The key value pairs to send to Petfinder.
        - completionHandlerForGetShelter: The completion handler in which the results will be handled or errors processed.
     */
    func getShelter(parameters: [String: AnyObject], completionHandlerForGetShelter: (results: AnyObject!, error: NSError?) -> Void) {
        func sendError(error: String) {
            let userInfo = [NSLocalizedDescriptionKey: error]
            completionHandlerForGetShelter(results: nil, error: NSError(domain: "getShelter", code: 1, userInfo: userInfo))
        }
        
        taskForGETMethod(Methods.FindShelter, parameters: parameters) { (result, error) in
            guard (error == nil) else {
                sendError(error!.localizedDescription)
                return
            }
            
            guard let petfinder = result[JSONResponseKeys.Petfinder] as? [String: AnyObject] else {
                sendError("Unable to retrieve petfinder key.")
                return
            }
            
            guard let shelter = petfinder[JSONResponseKeys.Shelter] as? [String: AnyObject] else {
                sendError("Unable to retrieve shelter key.")
                return
            }
            
            // Call the completion handler with the shelter JSON
            completionHandlerForGetShelter(results: shelter, error: nil)
        }
    }
    
    /**
     Function to retrieve a pet by ID from the Petfinder
     
     API Parameters and properties in ParameterKeys struct:
     
     Required:
     - Developer Key: your developer key
        - APIKey
     - ID: pet ID
        - ID
     
     Optional:
     - Token: Session token
        - SessionToken
     - Format: Response format: xml, json
        - ResultFormat
     
     - Parameters:
        - parameters: The key value pairs to send to Petfinder.
        - completionHandlerForGetPet: The completion handler in which the results will be handled or errors processed.
     */
    func getPet(parameters: [String: AnyObject], completionHandlerForGetPet: (results: AnyObject!, error: NSError?) -> Void) {
        func sendError(error: String) {
            let userInfo = [NSLocalizedDescriptionKey: error]
            completionHandlerForGetPet(results: nil, error: NSError(domain: "getPet", code: 1, userInfo: userInfo))
        }
        
        taskForGETMethod(Methods.FindShelter, parameters: parameters) { (result, error) in
            guard (error == nil) else {
                sendError(error!.localizedDescription)
                return
            }
            
            guard let petfinder = result[JSONResponseKeys.Petfinder] as? [String: AnyObject] else {
                sendError("Unable to retrieve petfinder key.")
                return
            }
            
            guard let pet = petfinder[JSONResponseKeys.Pet] as? [String: AnyObject] else {
                sendError("Unable to retrieve pet key.")
                return
            }
            
            // Call the completion handler with the pet JSON
            completionHandlerForGetPet(results: pet, error: nil)
        }
    }
}
