//
//  customAnnotation.swift
//  onTheMap
//
//  Created by Mickael Eriksson on 2015-08-18.
//  Copyright (c) 2015 Mickenet. All rights reserved.
//

import Foundation
import MapKit

class CustomAnnotation : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String
    var subtitle: String
    var detailURL: NSURL
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, detailURL: NSURL) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.detailURL = detailURL
    }
    
    func annotationView() -> MKAnnotationView {
        var view = MKAnnotationView(annotation: self, reuseIdentifier: "CustomAnnotation")
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.enabled = true
        view.canShowCallout = true
        view.image = UIImage(named: "AnnotationPin")
        //view.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        view.centerOffset = CGPointMake(0, -32)
        return view
    }
}