//
//  MapNavigationController.swift
//  onTheMap
//
//  Created by Mickael Eriksson on 2015-08-10.
//  Copyright (c) 2015 Mickenet. All rights reserved.
//

import Foundation
import UIKit

class MapNavigationController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        var retval = "test"
       UDYClient.sharedInstance().getPublicUserData(retval){ (data, errorString) in
            if data != nil{
              println(retval)
            } else {
                println("error")
            }
        }
    }
}