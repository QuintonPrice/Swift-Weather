//
//  FiveDayForecast.swift
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/20/22.
//

import SwiftUI

struct FiveDayForecast: View {
    
    @State private var apiArray = [FiveList]()
    
    var body: some View {
        // 5 day forecast
        HStack(spacing: 20) {
            ForEach(apiArray, id: \.self) { result in
                WeatherDayView(dayOfWeek: "DAY", imageID: result.weather[0].id, max: Int(result.temp.max), min: Int(result.temp.min))
            }
        }
        .task {
            let api = FiveDayAPI()
            apiArray = await api.handleAPIData()
        }
    }
}

struct WeatherDayView: View {
    
    // Takes openweathermap weather code, returns SFSymbols string
    func convertToSFSymbol(weatherCode: Int) -> String {
        if (weatherCode > 800) {
            return "sun.max.fill"
        } else {
            let intString = Int(String(weatherCode)[0]) // get first number
            
            switch(intString) {
            case (2):
                return "cloud.bolt.fill"
            case (3):
                return "cloud.rain.fill"
            case (5):
                return "cloud.heavyrain.fill"
            case (6):
                return "cloud.snow.fill"
            case (7):
                return "cloud.fog.fill"
            case (8):
                return "cloud.fill"
            default:
                return "cloud.sun.fill"
            }
        }
    }
    
    var dayOfWeek: String
    var imageID: Int
    
    var max: Int
    var min: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
                .shadow(radius: 5)
            
            Image(systemName: convertToSFSymbol(weatherCode: imageID))
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .shadow(radius: 5)
            
            Text("\(max)°")
                .font(.system(size: 26, weight: .medium, design: .default))
                .foregroundColor(.white)
                .shadow(radius: 5)
            Text("\(min)°")
                .font(.system(size: 18, weight: .medium, design: .default))
                .foregroundColor(.white)
                .shadow(radius: 4)
        }
    }
}

struct FiveDayForecast_Previews: PreviewProvider {
    static var previews: some View {
        FiveDayForecast()
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
