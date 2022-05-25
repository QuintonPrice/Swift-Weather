//
//  LocationData.swift
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/24/22.
//

import Foundation
import CoreLocation
import MapKit

 class LocationManager: NSObject, ObservableObject {
     
     private let locationManager = CLLocationManager()
     @Published var location: CLLocation? = nil
     
     override init() {
         super.init()
         self.locationManager.delegate = self
         self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
         self.locationManager.requestWhenInUseAuthorization()
         self.locationManager.startUpdatingLocation()
     }

//    init() {
//        var locationManager = CLLocationManager()
//
//        locationManager.requestWhenInUseAuthorization()
//
//        var currentLoc = locationManager.location
//
//        lat = Double((currentLoc?.coordinate.latitude)!)
//        lon = Double((currentLoc?.coordinate.latitude)!)
//
//        print(lat)
//        print(lon)
//    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.location = location
    }
}
