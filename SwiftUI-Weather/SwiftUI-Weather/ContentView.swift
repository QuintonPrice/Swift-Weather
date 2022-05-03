//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/2/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Seattle, WA")
                    .font(.system(size: 32, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding()
                
                VStack(spacing: 10){
                    Image(systemName: "cloud.sun.rain.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                    
                    Text("46°")
                        .font(.system(size: 70, weight: .medium, design: .default))
                        .foregroundColor(.white)
                }
                HStack {
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.heavyrain", temperature: "57°")
                    WeatherDayView(dayOfWeek: "WED", imageName: "cloud.heavyrain", temperature: "52°")
                    WeatherDayView(dayOfWeek: "THU", imageName: "cloud.heavyrain", temperature: "72°")
                    WeatherDayView(dayOfWeek: "FRI", imageName: "cloud.heavyrain", temperature: "49°")
                    WeatherDayView(dayOfWeek: "SAT", imageName: "cloud.heavyrain", temperature: "53°")
                    WeatherDayView(dayOfWeek: "SUN", imageName: "cloud.heavyrain", temperature: "55°")
                    
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
            ContentView()
                
        }
    }
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: String
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size:16, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text(temperature)
                .font(.system(size: 26, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
    }
}
