//
//  MapNavigationController.swift
//  onTheMap
//
//  Created by Mickael Eriksson on 2015-08-10.
//  Copyright (c) 2015 Mickenet. All rights reserved.
//

import Foundation
import UIKit

class MapNavigationController: UITabBarController  {
    var mates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         var tableView = self.viewControllers![1] as! TableViewController
        var mapView = self.viewControllers![0] as! MapViewController
        
        UDYClient.sharedInstance().getStudentLocations{ (data, errorString) in
            if data != nil{
                let locations: [studentLocation]  = data!
                mapView.locations = locations
                for location in locations {
                    self.mates.append(location.firstName + " " + location.lastName)
                               }
            } else {
                println("error")
            }
            tableView.matesList = self.mates
            
        }
    }
  
}