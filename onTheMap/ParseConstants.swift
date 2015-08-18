//
//  ParseConstants.swift
//  onTheMap
//
//  Created by Mickael Eriksson on 2015-08-14.
//  Copyright (c) 2015 Mickenet. All rights reserved.
//

import Foundation

extension UDYClient {
    
    struct ParseConstants {
        // URLs
        static let BaseURLSecure : String = "https://api.parse.com/1/classes/StudentLocation"
        static let ParseApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let RestApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"

    }
    struct ParseMethods {
        
        // Account
        static let Session = "session"
        static let Data = "users/{id}"
    }
    struct ParseJSONResponseKeys{
        static let createdAt = "createdAt"
        static let firstName = "firstName"
        static let lastName =  "lastName"
        static let latitude =  "latitude"
        static let longitude = "longitude"
        static let mapString = "mapString"
        static let mediaURL =  "mediaURL"
        static let objectId =  "objectId"
        static let uniqueKey = "uniqueKey"
        static let updatedAt = "updatedAt"
        
    }
    
}