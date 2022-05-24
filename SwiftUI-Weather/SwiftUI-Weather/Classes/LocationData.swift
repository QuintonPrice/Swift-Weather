//
//  LocationData.swift
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/24/22.
//

import Foundation
import CoreLocation

class Location {
    init() {
        let lat = (CLLocationManager().location?.coordinate.latitude)
        let lon = (CLLocationManager().location?.coordinate.longitude)
        
        print(lat ?? 0, " ", lon ?? 0)
    }
}
