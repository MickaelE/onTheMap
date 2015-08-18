//
//  ApiConstants.swift
//  onTheMap
//
//  Created by Mickael Eriksson on 2015-08-05.
//  Copyright (c) 2015 Mickenet. All rights reserved.
//

extension UDYClient {
    
    
 // Constants
struct Constants {
    
    // URLs
    static let BaseURLSecure : String = "https://www.udacity.com/api/"
    static let AuthorizationURL : String = "https://www.udacity.com/api/session"
    
        }
    struct JSONResponseKeys {
        
        // General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
        
        //Session
        static let session = "session"
        static let expiration = "expiration"
        static let SessionID = "id"
        
        // Account
        static let account = "account"
        static let registered = "registered"
        static let key = "key"
        
        //Data
        static let user = "user"
        static let last_name = "last_name"
        static let first_name = "first_name"
        static let website_url = "website_url"
        static let email = "email"

    }
    
    struct Methods {
        
        // Account
        static let Session = "session"
        static let Data = "users/{id}"
        static let Parse = "Parse"
           }

    struct ParameterKeys {
        
        static let ApiKey = "api_key"
        static let SessionID = "session_id"
        static let RequestToken = "request_token"
        static let Query = "query"
        
    }
    
    struct JSONBodyKeys {
        
        static let username = "username"
        static let passWord = "password"
        static let udacity = "udacity"
    }
    
    struct URLKeys {
        static let UserID = "id"
         static let SessonID = "SessionID"
    }

}