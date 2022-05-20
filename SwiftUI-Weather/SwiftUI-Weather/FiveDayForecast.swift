//
//  FiveDayForecast.swift
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/20/22.
//

import SwiftUI

// struct used for weather array
struct DayOfWeekWeather {
    let id = UUID()
    
    let dayOfWeek: String
    let imageName: String
    let temperature: Int
}

struct FiveDayForecast: View {
    
    // populate weather array
    let weather = [
        DayOfWeekWeather(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 57),
        DayOfWeekWeather(dayOfWeek: "WED", imageName: "cloud.moon.rain.fill", temperature: 52),
        DayOfWeekWeather(dayOfWeek: "THU", imageName: "sun.dust.fill", temperature: 72),
        DayOfWeekWeather(dayOfWeek: "FRI", imageName: "cloud.sun.fill", temperature: 49),
        DayOfWeekWeather(dayOfWeek: "SAT", imageName: "cloud.sun.fill", temperature: 53),
    ]
    
    var body: some View {
        // 5 day forecast
        HStack(spacing: 20) {
            ForEach(weather, id: \.id) { weather in
                WeatherDayView(dayOfWeek: weather.dayOfWeek,
                               imageName: weather.imageName,
                               temperature: weather.temperature)
            }
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
                .shadow(radius: 5)

            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .shadow(radius: 5)

            
            Text("\(temperature)°")
                .font(.system(size: 26, weight: .medium, design: .default))
                .foregroundColor(.white)
                .shadow(radius: 5)
        }
    }
}

struct FiveDayForecast_Previews: PreviewProvider {
    static var previews: some View {
        FiveDayForecast()
    }
}
