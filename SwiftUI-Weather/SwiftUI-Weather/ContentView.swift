//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundView(topColor: isNight ? .black : .blue, bottomColor: isNight ? .gray : Color("lightBlue"))
            
            VStack {
                
                CityTextView(cityName: "Seattle, WA")
                
                MainWeatherStatusView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: 46)
                
                HStack(spacing: 20) {
                    WeatherDayView(dayOfWeek: "TUE",
                                   imageName: "cloud.sun.fill",
                                   temperature: 57)
                    
                    WeatherDayView(dayOfWeek: "WED",
                                   imageName: "cloud.moon.rain.fill",
                                   temperature: 52)
                    
                    WeatherDayView(dayOfWeek: "THU",
                                   imageName: "sun.dust.fill",
                                   temperature: 72)
                    
                    WeatherDayView(dayOfWeek: "FRI",
                                   imageName: "cloud.sun.fill",
                                   temperature: 49)
                    
                    WeatherDayView(dayOfWeek: "SAT",
                                   imageName: "cloud.sun.fill",
                                   temperature: 53)
                    
                    WeatherDayView(dayOfWeek: "SUN",
                                   imageName: "cloud.sun.fill",
                                   temperature: 55)
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
    
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
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

struct WeekForecastView: View {
    
    var body: some View {
        HStack(spacing: 20) {
            WeatherDayView(dayOfWeek: "TUE",
                           imageName: "cloud.sun.fill",
                           temperature: 57)
            
            WeatherDayView(dayOfWeek: "WED",
                           imageName: "cloud.moon.rain.fill",
                           temperature: 52)
            
            WeatherDayView(dayOfWeek: "THU",
                           imageName: "sun.dust.fill",
                           temperature: 72)
            
            WeatherDayView(dayOfWeek: "FRI",
                           imageName: "cloud.sun.fill",
                           temperature: 49)
            
            WeatherDayView(dayOfWeek: "SAT",
                           imageName: "cloud.sun.fill",
                           temperature: 53)
            
            WeatherDayView(dayOfWeek: "SUN",
                           imageName: "cloud.sun.fill",
                           temperature: 55)
        }
    }
}


