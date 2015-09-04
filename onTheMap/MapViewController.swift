//
//  MapViewController.swift
//  onTheMap
//
//  Created by Mickael Eriksson on 2015-08-18.
//  Copyright (c) 2015 Mickenet. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locations = [studentLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.mapView.delegate = self
                for location in locations {
                    self.addLocations(location.latitude,long: location.longitude, title: location.firstName + " " + location.lastName)
                }
           }
    
    func addLocations(lat: Double, long: Double, title: String){
        
        var location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long
        )
        
        var span = MKCoordinateSpanMake(10, 10)
        var region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        annotation.subtitle = "Honduras"
        
        mapView.addAnnotation(annotation)

    }
    
}