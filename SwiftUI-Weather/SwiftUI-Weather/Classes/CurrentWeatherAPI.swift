//
//  CurrentAPI.swift
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/24/22.
//

import Foundation
import CoreLocation

class CurrentWeatherAPI {
    
    var weatherArray: [WeatherJSON] = []
    
    var lat: Double
    var lon: Double
    
    init() {
        lat = 999.9
        lon = 999.9
    }
    
    // sets latitude and longitude
    func setLatLon(latitude: Double, longitude: Double) {
        lat = latitude
        lon = longitude
    }
    
    // retrieves API data
    func handleAPIData() async -> [WeatherJSON] {

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=imperial&appid=673c2c51f8a9ae9ceacaee7a8e3aa885") else {
            print("This URL does not work!")
            return []
        }

        print(url)
        
        let decoder = JSONDecoder()

        do {
            let (weatherData, _) = try await URLSession.shared.data(from: url)
            if let weatherObj = try? decoder.decode(WeatherJSON.self, from: weatherData) {
                print("handleAPIData() on ContentView executed!")
                weatherArray.append(weatherObj)
                return weatherArray
            }

        } catch {
            print("Did not work :(")
        }
        return []
    }
    
    // used to test
    func printText() {
        print("This is a test from an APIData object!")
    }
}



// holds all data from the JSON request
struct WeatherJSON: Codable, Identifiable {
    
    let identity = UUID()
    
    var coord: Coord            // coordinate struct
    var weather: [Weather]      // array of Weather struct
    var base: String            // "internal parameter..?"
    var main: Main              // main struct (contains the juicy data)
    var visibility: Int         // visibility number
    var wind: Wind              // wind struct
    var clouds: Clouds          // clouds struct
    var dt: Int                 // time of data calculation, unix, UTC
    var sys: Sys                // internal parameer
    var timezone, id: Int       // timezone
    var name: String            // city namme
    var cod: Int                // another internal parameter (..?)
    
    init() {
        weather = []
        coord = Coord()
        base = "test"
        main = Main()
        visibility = 0
        wind = Wind()
        clouds = Clouds()
        dt = 0
        sys = Sys()
        timezone = 0
        id = 0
        name = "test name"
        cod = 0
    }
}

struct Clouds: Codable {
    var all: Int
    init() {
        all = 0
    }
}

struct Coord: Codable {
    var lon, lat: Double
    init() {
        lon = 32
        lat = 64
    }
}

struct Main: Codable {
    var temp: Double
    var pressure: Int
    var humidity: Int
    var temp_min: Double
    var temp_max: Double
    
    init() {
        temp = 0.0
        pressure = 0
        humidity = 0
        temp_min = 0.0
        temp_max = 0.0
    }
}

struct Sys: Codable {
    var type, id: Int
    var country: String
    var sunrise, sunset: Int
    
    init() {
        type = 0
        id = 0
        country = "USA"
        sunrise = 1000
        sunset = 2300
    }
}

struct Weather: Codable, Identifiable {
    
    let identity = UUID()
    
    var id: Int
    var main, description, icon: String
    
    init() {
        id = 1
        main = "Test main"
        description = "Yep, it's raining"
        icon = "9d0"
    }
}

struct Wind: Codable {
    var speed: Double
    var deg: Int
    
    init() {
        speed = 100
        deg = 100
    }
}
