//
//  MainWeatherStatusView.swift
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/19/22.
//

import SwiftUI

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    var description: String
    var high, low: Int
    
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
            
            Text("\(description.capitalized)")
                .font(.system(size: 30, weight: .bold, design: .default))
                .foregroundColor(.white)
            
            Text("H: \(high)°  L: \(low)°")
                .font(.system(size: 20, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}
