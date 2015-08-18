//
//  ParseConvinience.swift
//  onTheMap
//
//  Created by Mickael Eriksson on 2015-08-14.
//  Copyright (c) 2015 Mickenet. All rights reserved.
//

import Foundation

extension UDYClient{
    func getStudentLocations( completionHandler: (data: [studentLocation]?, error: NSError?) -> Void) {
        
        var parameters = [String: AnyObject]()
        parameters["limit"] = "100"
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