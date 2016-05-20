//
//  PetfinderClient.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 5/15/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

import Foundation

class PetfinderClient {
    
    // MARK: Properties
    
    // Shared session
    var session = NSURLSession.sharedSession()
    
    // Shared instance of PetfinderClient
    static let sharedInstance = PetfinderClient()
    
    
    // MARK: GET
    
    func taskForGETMethod(method: String, parameters: [String: AnyObject]?, completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        let request = NSURLRequest(URL: createPetfinderURLFromParameters(method, parameters: parameters))
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            // Error handling function
            func sendError(error: String) {
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForGET(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            // Check for errors from the request
            
            guard error == nil else {
                sendError(error!.localizedDescription)
                return
            }
            
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode else {
                sendError("Cannot access HTTP status.")
                return
            }
            
            guard (statusCode >= 200 && statusCode <= 299) else {
                sendError("Received an invalid status code: \(statusCode)")
                return
            }
            
            guard let data = data else {
                sendError("Cannot access data from Petfinder.")
                return
            }
            
            var parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            } catch let error as NSError {
                sendError("JSON error: \(error.localizedDescription)")
            }
            
            completionHandlerForGET(result: parsedResult, error: nil)
        }
        task.resume()
        
        return task
    }
    
    
    // MARK: Helper Functions
    
    func createPetfinderURLFromParameters(method: String, parameters: [String: AnyObject]?) -> NSURL {
        let components = NSURLComponents()
        components.scheme = Constants.APIScheme
        components.host = Constants.APIHost
        components.path = method
        
        if let parameters = parameters {
            // Add standard parameters.  
            // Every request will require the API key, and the code expects to receive a JSON response from the API.
            var newParameters = parameters
            newParameters[ParameterKeys.APIKey] = ParameterValues.APIKey
            newParameters[ParameterKeys.ResultFormat] = ParameterValues.JSONFormat
                
            components.queryItems = [NSURLQueryItem]()
            
            for(key, value) in newParameters {
                let queryItem = NSURLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }
        
        return components.URL!
    }
    
}
