//
//  UDYclient.swift
//  onTheMap
//
//  Created by Mickael Eriksson on 2015-08-05.
//  Copyright (c) 2015 Mickenet. All rights reserved.
//

import Foundation
import UIKit

class UDYClient : NSObject {
    
    var session: NSURLSession
    var sessionID : String? = nil
    var cred: UDYCredetials = UDYCredetials()
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    /*
    This function get response from webservice by first post an json message.
    */
    
    func taskForPOSTMethod(method: String, parameters: [String : AnyObject], jsonBody: [String:AnyObject], completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        var mutableParameters = parameters
        
        let urlString = Constants.BaseURLSecure + method + UDYClient.escapedParameters(mutableParameters)
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        var jsonifyError: NSError? = nil
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(jsonBody, options: nil, error: &jsonifyError)
    
        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            
            if let error = downloadError {
                let newError = UDYClient.errorForData(data, response: response, error: error)
                completionHandler(result: nil, error: downloadError)
            } else {
                let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
               // println(NSString(data: newData, encoding: NSUTF8StringEncoding))
                UDYClient.parseJSONWithCompletionHandler(newData, completionHandler: completionHandler)
            }
        }
       
        task.resume()
        
        return task
    }
    
    /*
    This function get response from webservice by GET method.
    */
    func taskForGETMethod(method: String, parameters: [String : AnyObject], completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        var mutableParameters = parameters
        
        //var mutableMethod : String = method
       // mutableMethod = UDYClient.subtituteKeyInMethod(mutableMethod, key: UDYClient.URLKeys.UserID, value: UDYClient.sharedInstance().sessionID!)!
        
        let urlString = UDYClient.createURL(method) + UDYClient.escapedParameters(mutableParameters)
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        
        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            
            if let error = downloadError {
                let newError = UDYClient.errorForData(data, response: response, error: error)
                completionHandler(result: nil, error: downloadError)
            } else {
               let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
               //println(NSString(data: newData, encoding: NSUTF8StringEncoding))
                UDYClient.parseJSONWithCompletionHandler(newData, completionHandler: completionHandler)
            }
        }
        
        task.resume()
        
        return task
    }
    
    func taskForGETMutableMethod(method: String, parameters: [String : AnyObject], completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        var mutableParameters = parameters
        
        //var mutableMethod : String = method
        // mutableMethod = UDYClient.subtituteKeyInMethod(mutableMethod, key: UDYClient.URLKeys.UserID, value: UDYClient.sharedInstance().sessionID!)!
        
        let urlString = UDYClient.createURL(method) + UDYClient.escapedParameters(mutableParameters)
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
       // if method == UDYClient.Methods.Parse{
            request.addValue(ParseConstants.ParseApplicationID, forHTTPHeaderField: "X-Parse-Application-Id")
            request.addValue(ParseConstants.RestApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
       // }
        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            
            if let error = downloadError {
                let newError = UDYClient.errorForData(data, response: response, error: error)
                completionHandler(result: nil, error: downloadError)
            } else {
              // println(NSString(data: data, encoding: NSUTF8StringEncoding))
                UDYClient.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)
            }
        }
        
        task.resume()
        
        return task
    }

    class func createURL(method: String)->String {
        var retVal = ""
        
        switch method {
        case  UDYClient.Methods.Session:
           retVal =  Constants.BaseURLSecure + method
        case UDYClient.Methods.Data:
            retVal = Constants.BaseURLSecure + UDYClient.subtituteKeyInMethod(method, key: UDYClient.URLKeys.UserID, value: UDYClient.sharedInstance().sessionID!)!
        case UDYClient.Methods.Parse:
            retVal = ParseConstants.BaseURLSecure
        default:
            retVal = ""
        }
        return(retVal)
    }
    /*
    This function will take an dictionary and make an string with  escaped text,
    */
    class func escapedParameters(parameters: [String : AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
            
            let stringValue = "\(value)"
            
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            urlVars += [key + "=" + "\(escapedValue!)"]
        }
        return (!urlVars.isEmpty ? "?" : "") + join("&", urlVars)
    }
    
    /*
    Fucntion to return a good error message.
    */
    class func errorForData(data: NSData?, response: NSURLResponse?, error: NSError) -> NSError {
        
        if let parsedResult = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as? [String : AnyObject] {
            
            if let errorMessage = parsedResult[UDYClient.JSONResponseKeys.StatusMessage] as? String {
                
                let userInfo = [NSLocalizedDescriptionKey : errorMessage]
                
                return NSError(domain: "UDACITY Error", code: 1, userInfo: userInfo)
            }
        }
        
        return error
    }
    
    /*
    Handle parse Json response.
    */
    class func parseJSONWithCompletionHandler(data: NSData, completionHandler: (result: AnyObject!, error: NSError?) -> Void) {
        
        var parsingError: NSError? = nil
        
        let parsedResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError)

        if let error = parsingError {
            println("Error from JSON =%@", error)
            completionHandler(result: nil, error: error)
        } else {
            completionHandler(result: parsedResult, error: nil)
        }
    }
    
    
    /*
    Creates an memmory instance.
    */
    class func sharedInstance() -> UDYClient {
        
        struct Singleton {
            static var sharedInstance = UDYClient()
        }
        
        return Singleton.sharedInstance
    }
    
    /*
    Replaces a word with anohther in string.
    */
    class func subtituteKeyInMethod(method: String, key: String, value: String) -> String? {
        if method.rangeOfString("{\(key)}") != nil {
            return method.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
        } else {
            return nil
        }
    }


}