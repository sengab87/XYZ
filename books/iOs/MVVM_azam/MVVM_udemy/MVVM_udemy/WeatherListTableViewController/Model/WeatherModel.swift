//
//  WeatherModel.swift
//  MVVM_udemy
//
//  Created by Ahmed Sengab on 12/14/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import UIKit

struct WeatherModel : Decodable {
    let name : String
    var currentTemperature : TemperatureModel
    private enum CodingKeys: String, CodingKey{
        case name
        case currentTemperature = "main"
    }
}
struct TemperatureModel : Decodable {
    var temperature : Double
    let temperatureMin : Double
    let temperatureMax : Double
   private enum CodingKeys : String, CodingKey
    {
        case temperature  = "temp"
        case temperatureMin  = "temp_min"
        case temperatureMax  = "temp_max"
        
    }
}
