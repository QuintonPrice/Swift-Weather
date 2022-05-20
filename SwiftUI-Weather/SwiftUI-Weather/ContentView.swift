//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/2/22.
//

import SwiftUI

// holds all data from the JSON request
struct WeatherJSON: Codable, Hashable {
    
    // checking stoof
    static func == (lhs: WeatherJSON, rhs: WeatherJSON) -> Bool {
        lhs.name == rhs.name
    }
    
    // hashing stoof
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
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

struct Weather: Codable, Hashable {
    
    // checking stoof
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        lhs.main == rhs.main
    }
    
    // hashing stoof
    func hash(into hasher: inout Hasher) {
        hasher.combine(main)
    }
    
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

// struct used for weather array
struct DayOfWeekWeather {
    let id = UUID()
    
    let dayOfWeek: String
    let imageName: String
    let temperature: Int
}

// Main ContentView
struct ContentView: View {
    
    // used for darkmode
    @State private var isNight = false
    @State private var weatherArray: [WeatherJSON] = []
    
    // populate weather array
    let weather = [
        DayOfWeekWeather(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 57),
        DayOfWeekWeather(dayOfWeek: "WED", imageName: "cloud.moon.rain.fill", temperature: 52),
        DayOfWeekWeather(dayOfWeek: "THU", imageName: "sun.dust.fill", temperature: 72),
        DayOfWeekWeather(dayOfWeek: "FRI", imageName: "cloud.sun.fill", temperature: 49),
        DayOfWeekWeather(dayOfWeek: "SAT", imageName: "cloud.sun.fill", temperature: 53),
    ]
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            
            VStack {
                ForEach(weatherArray, id: \.self) { result in
                    CityTextView(cityName: (result.name), countryName: (result.sys.country))
                    MainWeatherStatusView(
                        imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill",
                        temperature: Int(convertTemperature(temp: (result.main.temp), from: .kelvin, to: .fahrenheit)),
                        description: result.weather[0].description,
                        high: Int(convertTemperature(temp: (result.main.temp_max), from: .kelvin, to: .fahrenheit)),
                        low: Int(convertTemperature(temp: (result.main.temp_min), from: .kelvin, to: .fahrenheit)))
                }
//                // 5 day forecast
                HStack(spacing: 20) {
                    ForEach(weather, id: \.id) { weather in
                        WeatherDayView(dayOfWeek: weather.dayOfWeek,
                                       imageName: weather.imageName,
                                       temperature: weather.temperature)
                    }
                }
                
                Spacer()
                
                // toggle dark mode button
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Toggle Dark Mode", textColor: .blue, backgroundColor: .white)
                }
            }
        }
        .task { await handleAPIData() } // loads all data
    }
    
    // retrieves API data
    func handleAPIData() async {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=47.6062&lon=-122.3321&appid=673c2c51f8a9ae9ceacaee7a8e3aa885") else {
            print("This URL does not work!")
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let (weatherData, _) = try await URLSession.shared.data(from: url)
            if let weatherObj = try? decoder.decode(WeatherJSON.self, from: weatherData) {
                weatherArray.append(weatherObj)
                // print(weatherArray[0])
            }
            
        } catch {
            print("Did not work :(")
        }
    }
    
    // Converts the temperature
    func convertTemperature(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> Double {
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return output.value
    }
}


struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 26, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}


struct CityTextView: View {
    
    var cityName: String
    var countryName: String
    
    var body: some View {
        Text("\(cityName), \(countryName)")
            .font(.system(size: 37, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
