//
//  SettingsModel.swift
//  MVVM_udemy
//
//  Created by Ahmed Sengab on 12/14/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
enum Unit : String, CaseIterable
{
    
    case fahrenheit = "imperial"
    case celsius = "metric"
    var displayName : String {
        get {
            switch(self){
            case . celsius :
                return "Celsius"
            case . fahrenheit :
                return "Fahrenheit"
            }
        }
    }
}
