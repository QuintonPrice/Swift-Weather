//
//  ConvertToSF.swift
//  SwiftUI-Weather
//
//  Created by Quinton Price on 5/24/22.
//

import Foundation

class SFConverted {
    
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
}
