//
//  TemperatureView.swift
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/19/22.
//

import SwiftUI

//// holds all data from the JSON request
//struct WeatherJSON: Codable, Hashable {
//    
//    // checking stoof
//    static func == (lhs: WeatherJSON, rhs: WeatherJSON) -> Bool {
//        lhs.name == rhs.name
//    }
//    
//    // hashing stoof
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(name)
//    }
//    
//    var coord: Coord            // coordinate struct
//    var weather: [Weather]      // array of Weather struct
//    var base: String            // "internal parameter..?"
//    var main: Main              // main struct (contains the juicy data)
//    var visibility: Int         // visibility number
//    var wind: Wind              // wind struct
//    var clouds: Clouds          // clouds struct
//    var dt: Int                 // time of data calculation, unix, UTC
//    var sys: Sys                // internal parameer
//    var timezone, id: Int       // timezone
//    var name: String            // city namme
//    var cod: Int                // another internal parameter (..?)
//}
//
//struct Clouds: Codable {
//    var all: Int
//    init() {
//        all = 0
//    }
//}
//
//struct Coord: Codable {
//    var lon, lat: Double
//    init() {
//        lon = 32
//        lat = 64
//    }
//}
//
//struct Main: Codable {
//    var temp: Double
//    var pressure: Int
//    var humidity: Int
//    var temp_min: Double
//    var temp_max: Double
//    
//    init() {
//        temp = 0.0
//        pressure = 0
//        humidity = 0
//        temp_min = 0.0
//        temp_max = 0.0
//    }
//}
//
//struct Sys: Codable {
//    var type, id: Int
//    var country: String
//    var sunrise, sunset: Int
//    
//    init() {
//        type = 0
//        id = 0
//        country = "USA"
//        sunrise = 1000
//        sunset = 2300
//    }
//}
//
//struct Weather: Codable, Hashable {
//    
//    // checking stoof
//    static func == (lhs: Weather, rhs: Weather) -> Bool {
//        lhs.main == rhs.main
//    }
//    
//    // hashing stoof
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(main)
//    }
//    
//    var id: Int
//    var main, description, icon: String
//    
//    init() {
//        id = 1
//        main = "Test main"
//        description = "Yep, it's raining"
//        icon = "9d0"
//    }
//}
//
//struct Wind: Codable {
//    var speed: Double
//    var deg: Int
//    
//    init() {
//        speed = 100
//        deg = 100
//    }
//}

struct TemperatureView: View {
    
    @State private var weatherArray: [WeatherJSON] = []

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView()
    }
}
