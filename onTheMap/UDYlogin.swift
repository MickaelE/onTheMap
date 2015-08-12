//
//  UDY.swift
//  onTheMap
//
//  Created by Mickael Eriksson on 2015-08-05.
//  Copyright (c) 2015 Mickenet. All rights reserved.
//

import Foundation

struct UDYlogin {
    
    var SessionDic: AnyObject! = nil
    var accountDic: AnyObject! = nil
    
    init(dictionary: [String : AnyObject]) {
        SessionDic = dictionary[UDYClient.JSONResponseKeys.session] as AnyObject?
        accountDic = dictionary[UDYClient.JSONResponseKeys.account] as AnyObject?
    }
    
    static func loginFromResults(results: [[String : AnyObject]]) -> [UDYlogin] {
        var login = [UDYlogin]()
        
        for result in results {
            login.append(UDYlogin(dictionary: result))
        }
        
        return login
    }
}


struct UDYCredetials {
    var email: String!
    var passWord: String!
}

struct UDYdata {
    var last_name: String
    var first_name: String
    var website_url: String
    var email: String
   
    init(dictionary: [String : AnyObject]) {
        last_name   = (dictionary[UDYClient.JSONResponseKeys.last_name] as! String?)!
        first_name  = (dictionary[UDYClient.JSONResponseKeys.first_name] as! String?)!
        website_url = (dictionary[UDYClient.JSONResponseKeys.website_url] as! String?)!
        email       = (dictionary[UDYClient.JSONResponseKeys.email] as! String?)!
    }
    
    static func dataFromResults(results: [[String : AnyObject]]) -> [UDYdata] {
        var login = [UDYdata]()
        
        for result in results {
            login.append(UDYdata(dictionary: result))
        }
        
        return login
    }
}