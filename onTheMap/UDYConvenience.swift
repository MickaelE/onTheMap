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
    /*
    Function to handle login to app from udacity.
    */
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
    
    /*
    Function to get a sessionID from Udacity. EG. login.
    */
    func getSessionID(credetials: UDYCredetials, completionHandler: (result: String?, error: NSError?) -> Void) {
        let parameters = [String: AnyObject]()
        var mutableMethod : String = Methods.Session
        let jsonBody : [String:AnyObject] = [ UDYClient.JSONBodyKeys.udacity: [
            UDYClient.JSONBodyKeys.username: credetials.email   ,
            UDYClient.JSONBodyKeys.passWord: credetials.passWord
        ]]
        let task = taskForPOSTMethod(mutableMethod, parameters: parameters, jsonBody: jsonBody) { JSONResult, error in
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
    
    /* 
    Get userdata from UDACITYS webservice
    */
    func getPublicUserData(seessionID: String, completionHandler: (data: UDYUserData?, error: NSError?) -> Void) {
        
        let parameters = [String: AnyObject]()
        var mutableMethod : String = Methods.Data

        mutableMethod = UDYClient.subtituteKeyInMethod(mutableMethod, key: UDYClient.URLKeys.UserID, value: UDYClient.sharedInstance().sessionID!)!
        
        taskForGETMethod(Methods.Data, parameters: parameters) { JSONResult, error in
            
            if let error = error {
                completionHandler(data: nil, error: NSError(domain: "Udacity data parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse Udacity data"]))
            } else {
               // println(JSONResult)
                if let results = JSONResult.valueForKey("user") as? NSDictionary {
                    var newData = UDYUserData(dictionary: results)
                      completionHandler(data: newData,  error: nil)
                } else {
                    completionHandler(data: nil , error: NSError(domain: "Udacity data parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse Udactiy data"]))
                }
            }
        }
    }

}