//
//  FiveDayAPI
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/24/22.
//

import Foundation

class FiveDayAPI {
    
    var fiveDayArray = [FiveList]()
    
    func handleAPIData() async -> [FiveList] {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast/daily?lat=46.0493&lon=-118.3883&units=imperial&appid=673c2c51f8a9ae9ceacaee7a8e3aa885&cnt=5") else {
            print("This URL does not work!")
            return []
        }
        
        let decoder = JSONDecoder()
        
        do {
            let (weatherData, _) = try await URLSession.shared.data(from: url)
            if let weatherObj = try? decoder.decode(FiveDayJSON.self, from: weatherData) {
                print("handleAPIData() on FiveDayForecast executed!")
                fiveDayArray = weatherObj.list
                return fiveDayArray
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

struct FiveDayJSON: Codable, Hashable {
    
    static func == (lhs: FiveDayJSON, rhs: FiveDayJSON) -> Bool {
        lhs.city.name == rhs.city.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(city.name)
    }
    
    let city: City
    let cod: String
    let message: Double
    let cnt: Int
    let list: [FiveList]
    
    init() {

        city = City()
        cod = "cod"
        message = 0
        cnt = 0
        list = []
    }
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: FiveCoord
    let country: String
    let population, timezone: Int
    init() {
        id = 1
        name = "name"
        coord = FiveCoord()
        country = "country"
        population = 0
        timezone = 0
    }
}

struct FiveCoord: Codable {
    var lon, lat: Double
    init() {
        lon = 0
        lat = 0
    }
}

// The actual list of temperatures - this is what we need!
struct FiveList: Codable, Hashable {
    
    static func == (lhs: FiveList, rhs: FiveList) -> Bool {
        lhs.sunrise == rhs.sunrise
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(sunrise)
    }
    
    var dt, sunrise, sunset: Int
    var temp: Temp
    var feels_like: FeelsLike
    var pressure, humidity: Int
    var weather: [FiveWeather]
    var speed: Double
    var deg: Int
    var gust: Double
    var clouds: Int
    var pop: Double
    var rain: Double?
    
    
    init() {
        dt = 0
        sunrise = 0
        sunset = 0
        temp = Temp()
        feels_like = FeelsLike()
        pressure = 0
        humidity = 0
        weather = []
        speed = 0
        deg = 1
        gust = 1
        clouds = 1
        pop = 1
        rain = 1
    }
}

struct FeelsLike: Codable {
    var day, night, eve, morn: Double
    init() {
        day = 0
        night = 0
        eve = 0
        morn = 0
    }
}

struct Temp: Codable {
    var day, min, max, night: Double
    var eve, morn: Double
    init() {
        day = 0
        min = 0
        max = 0
        night = 0
        eve = 0
        morn = 0
    }
}

struct FiveWeather: Codable, Identifiable {
    
    static func == (lhs: FiveWeather, rhs: FiveWeather) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: Int
    var main: String
    var description: String
    var icon: String
    init() {
        id = 0
        main = "main"
        description = "description"
        icon = "icon"
    }
}

