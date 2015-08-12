//
//  UDYConvinience.swift
//  onTheMap
//
//  Created by Mickael Eriksson on 2015-08-05.
//  Copyright (c) 2015 Mickenet. All rights reserved.
//

import Foundation
import UIKit

extension UDYClient {
    
    func authenticateWithViewController(hostViewController: UIViewController, completionHandler: (success: Bool, errorString: String?) -> Void) {
        self.getSessionID(cred)
            { (result, errorString) in
                if (result != nil) {
                    UDYClient.sharedInstance().sessionID = result
                    completionHandler(success: true, errorString: nil)
                } else {
                    //  completionHandler(success: false, errorString: errorString as! NSError)
                }
        }
    }
    
    /*Login to Udacity direct.*/
    func getSessionID(credetials: UDYCredetials, completionHandler: (result: String?, error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [String: AnyObject]()
        var mutableMethod : String = Methods.Session
        let jsonBody : [String:AnyObject] = [ UDYClient.JSONBodyKeys.udacity: [
            UDYClient.JSONBodyKeys.username: credetials.email   ,
            UDYClient.JSONBodyKeys.passWord: credetials.passWord
        ]]
        
        /* 2. Make the request */
        let task = taskForPOSTMethod(mutableMethod, parameters: parameters, jsonBody: jsonBody) { JSONResult, error in
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                
                if let results = JSONResult.valueForKey(UDYClient.JSONResponseKeys.account) as? NSDictionary {
                    let id = results.valueForKey("key") as! String
                    completionHandler(result: id, error: nil)
                } else {
                    completionHandler(result: nil, error: NSError(domain: "sessionID parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse sessionID"]))
                }
            }
        }
    }
    
    /* Get data from UDACITYS webservice*/
    func getPublicUserData(seessionID: String, completionHandler: (data: [UDYdata]?, error: NSError?) -> Void) {
        
        let parameters = [String: AnyObject]()
        var mutableMethod : String = Methods.Data
        
        mutableMethod = UDYClient.subtituteKeyInMethod(mutableMethod, key: UDYClient.URLKeys.UserID, value: UDYClient.sharedInstance().sessionID!)!
        
        /* 2. Make the request */
        taskForGETMethod(Methods.Data, parameters: parameters) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(data: nil, error: NSError(domain: "Udacity data parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse Udacity data"]))
            } else {
                if let results = JSONResult.valueForKey("user") as? [[String : AnyObject]] {
                      var newData = UDYdata.dataFromResults(results)
                    completionHandler(data: newData,  error: nil)
                } else {
                    completionHandler(data: nil , error: NSError(domain: "Udacity data parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse Udactiy data"]))
                }
            }
        }
    }

}