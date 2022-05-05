//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/2/22.
//

import SwiftUI

// struct used for weather array
struct Weather {
    let id = UUID()
    
    let dayOfWeek: String
    let imageName: String
    let temperature: Int
}

// Main ContentView
struct ContentView: View {
    
    // used for darkmode
    @State private var isNight = false
    
    // populate weather array
    let weather = [
        Weather(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 57),
        Weather(dayOfWeek: "WED", imageName: "cloud.moon.rain.fill", temperature: 52),
        Weather(dayOfWeek: "THU", imageName: "sun.dust.fill", temperature: 72),
        Weather(dayOfWeek: "FRI", imageName: "cloud.sun.fill", temperature: 49),
        Weather(dayOfWeek: "SAT", imageName: "cloud.sun.fill", temperature: 53),
    ]
    
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            
            VStack {
                CityTextView(cityName: "Seattle, WA")
                MainWeatherStatusView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: 46)
                
                // 5 day forecast
                HStack(spacing: 20) {
                    ForEach(weather, id: \.id) { weather in
                        WeatherDayView(dayOfWeek: weather.dayOfWeek,
                                       imageName: weather.imageName,
                                       temperature: weather.temperature)
                    }
                }
                
                Spacer()
                
                Button {
                    isNight.toggle() // toggles boolean value
                } label: {
                    WeatherButton(title: "Toggle Dark Mode", textColor: .blue, backgroundColor: .white)
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            
            
        }
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
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}

//struct WeekForecastView: View {
//
//    var body: some View {
//        HStack(spacing: 20) {
//            WeatherDayView(dayOfWeek: "TUE",
//                           imageName: "cloud.sun.fill",
//                           temperature: 57)
//
//            WeatherDayView(dayOfWeek: "WED",
//                           imageName: "cloud.moon.rain.fill",
//                           temperature: 52)
//
//            WeatherDayView(dayOfWeek: "THU",
//                           imageName: "sun.dust.fill",
//                           temperature: 72)
//
//            WeatherDayView(dayOfWeek: "FRI",
//                           imageName: "cloud.sun.fill",
//                           temperature: 49)
//
//            WeatherDayView(dayOfWeek: "SAT",
//                           imageName: "cloud.sun.fill",
//                           temperature: 53)
//
//            WeatherDayView(dayOfWeek: "SUN",
//                           imageName: "cloud.sun.fill",
//                           temperature: 55)
//        }
//    }
//}