//
//  FiveDayForecast.swift
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/20/22.
//

import SwiftUI
import CoreLocation

struct FiveDayForecast: View {
    
    var lat = 0.0
    var lon = 0.0
    
    @State private var apiArray = [FiveList]()
    @ObservedObject private var locationManager = LocationManager()
    
    var body: some View {
                
        // 5 day forecast
        return HStack(spacing: 20) {
            ForEach(apiArray, id: \.self) { result in
                WeatherDayView(dayOfWeek: "DAY", imageID: result.weather[0].id, max: Int(result.temp.max), min: Int(result.temp.min))
            }
        }
        .task {
            let fiveApi = FiveDayWeatherAPI()
            fiveApi.setLatLon(latitude: lat, longitude: lon)
            apiArray = await fiveApi.handleAPIData()
        }
    }
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageID: Int
    
    var max: Int
    var min: Int
    
    var sf = SFConverted()
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
                .shadow(radius: 5)
            
            Image(systemName: sf.convertToSFSymbol(weatherCode: imageID))
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
