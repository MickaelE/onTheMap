
//
//  Parce.swift
//  onTheMap
//
//  Created by Mickael Eriksson on 2015-08-14.
//  Copyright (c) 2015 Mickenet. All rights reserved.
//

import Foundation

struct studentLocation {
    var createdAt: String //"2015-02-24T22:35:30.639Z",
    var firstName: String  //"Gabrielle",
    var lastName:  String //"Miller-Messner",
    var latitude:  Double //35.1740471,
    var longitude: Double //-79.3922539,
    var mapString: String //"Southern Pines, NC",
    var mediaURL:  String //"http://www.linkedin.com/pub/gabrielle-miller-messner/11/557/60/en",
    var objectId:  String //"8ZEuHF5uX8",
    var uniqueKey: String  //"2256298598",
    var updatedAt: String //"2015-03-09T22:06:11.615Z"
    
    init(Data: NSDictionary){
        createdAt   = (Data[UDYClient.ParseJSONResponseKeys.createdAt] as! String?)!
        firstName   = (Data[UDYClient.ParseJSONResponseKeys.firstName] as! String?)!
        lastName    = (Data[UDYClient.ParseJSONResponseKeys.lastName] as! String?)!
        longitude   = (Data[UDYClient.ParseJSONResponseKeys.longitude] as! Double?)!
        latitude    = (Data[UDYClient.ParseJSONResponseKeys.latitude] as! Double?)!
        mapString   = (Data[UDYClient.ParseJSONResponseKeys.mapString] as! String?)!
        mediaURL    = (Data[UDYClient.ParseJSONResponseKeys.mediaURL] as! String?)!
        objectId    = (Data[UDYClient.ParseJSONResponseKeys.objectId] as! String?)!
        uniqueKey   = (Data[UDYClient.ParseJSONResponseKeys.uniqueKey] as! String?)!
        updatedAt   = (Data[UDYClient.ParseJSONResponseKeys.updatedAt] as! String?)!
    }
    
    static func getStudentLocations(DataArray: NSArray) ->[studentLocation]{
          var studentLocations = [studentLocation]()
        for data in DataArray{
            let obj = data as! NSDictionary
          studentLocations.append(studentLocation(Data: obj))
        }
        return studentLocations
    }
}