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
}
