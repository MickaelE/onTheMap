//
//  ParseConvinience.swift
//  onTheMap
//
//  Created by Mickael Eriksson on 2015-08-14.
//  Copyright (c) 2015 Mickenet. All rights reserved.createdAt
//

import Foundation

extension UDYClient{
    
    func setStudentLoction( completionHandler: (result: String?, error: NSError?) -> Void) {
        let parameters = [String: AnyObject]()
        
        UDYClient.sharedInstance().getPublicUserData( UDYClient.sharedInstance().sessionID! ){ (data, errorString) in
            if data != nil {
                
        let jsonBody : [String:AnyObject] = [
            UDYClient.ParseJSONBodyKeys.uniqueKey: "6912"  ,
            UDYClient.ParseJSONBodyKeys.firstName: data!.first_name ,
            UDYClient.ParseJSONBodyKeys.lastName: data!.last_name ,
          //  UDYClient.ParseJSONBodyKeys.mapString: myLocation.mapString ,
            UDYClient.ParseJSONBodyKeys.mediaURL: "" ,
           // UDYClient.ParseJSONBodyKeys.latitude: myLocation.latitude ,
           // UDYClient.ParseJSONBodyKeys.longitude: myLocation.longitude
        ]

        var mutableMethod : String = Methods.post
         println(jsonBody)
        let task = self.taskForPOSTMethod(mutableMethod, parameters: parameters, jsonBody: jsonBody) { JSONResult, error in
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                if let results = JSONResult.valueForKey("createdAt") as? String {
                    completionHandler(result: results, error: nil)
                } else {
                    completionHandler(result: nil, error: NSError(domain: "sessionID parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse sessionID"]))
                }
            }
        }
            } else {
                
            }
        }

    }
    
    func getStudentLocations( completionHandler: (data: [studentLocation]?, error: NSError?) -> Void) {
        
        var parameters = [String: AnyObject]()
        parameters["limit"] = "200"
         parameters["order"] = "-latitude,longitude"

        
        taskForGETMutableMethod(Methods.Parse, parameters: parameters) { JSONResult, error in
            if let error = error {
                completionHandler(data: nil, error: NSError(domain: "Udacity data parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse Udacity data"]))
            } else {
                if let studentLocations: NSArray = JSONResult.valueForKey("results") as? NSArray {
                    let newData = studentLocation.getStudentLocations(studentLocations)
                    completionHandler(data: newData,  error: nil)
                } else {
                    completionHandler(data: nil , error: NSError(domain: "Udacity data parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse Udactiy data"]))
                }
            }
        }
    }
    
}