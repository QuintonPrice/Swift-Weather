//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/2/22.
//

import SwiftUI


// Main ContentView
struct ContentView: View {
    
    // used for darkmode
    @State private var isNight = false
    @State private var apiArray = [WeatherJSON]()
    
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            
            VStack {
                ForEach(apiArray) { result in
                    
                    CityTextView(cityName: (result.name), countryName: (result.sys.country))
                    
                    MainWeatherStatusView(
                        imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill",
                        
                        temperature: Int(result.main.temp),
                        
                        description: result.weather[0].description,
                        
                        high: Int((result.main.temp_max)),
                        
                        low: Int(result.main.temp_min))
                    
                }
                
                FiveDayForecast()
                
                Spacer()
            }
        }
        .task {
            let api = CurrentAPI()
            apiArray = await api.handleAPIData()
        }
//        Button {
//            let lat = Location()
//        } label: {
//            WeatherButton(title: "Print Coordinates", textColor: .blue, backgroundColor: .white)
//        }
    }
}

struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : Color("topColor"), isNight ? .gray : Color("bottomColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
            .shadow(radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
