//
//  UDY.swift
//  onTheMap
//
//  Created by Mickael Eriksson on 2015-08-05.
//  Copyright (c) 2015 Mickenet. All rights reserved.
//

import Foundation

/*
Structure to hold logindata.
*/

struct UDYCredetials {
    var email: String!
    var passWord: String!
}

/*
Structure to hold Data for a user.
*/
struct UDYUserData {
    var last_name: String
    var first_name: String
    var website_url: String
    var email: String
   
    init(dictionary: NSDictionary ) {
        last_name   = (dictionary[UDYClient.JSONResponseKeys.last_name] as! String?)!
        first_name  = (dictionary[UDYClient.JSONResponseKeys.first_name] as! String?)!
        website_url = "" //(dictionary[UDYClient.JSONResponseKeys.website_url] as! String?)!
        email       = "" //(dictionary[UDYClient.JSONResponseKeys.email] as! String?)!
    }
}
