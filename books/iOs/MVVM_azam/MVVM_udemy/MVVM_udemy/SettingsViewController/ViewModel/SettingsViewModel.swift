//
//  SettingsViewModel.swift
//  MVVM_udemy
//
//  Created by Ahmed Sengab on 12/14/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
struct SettingsViewModel {
    let Units = Unit.allCases
    private var _selectedUnit : Unit = Unit.fahrenheit
    var selectedUnit : Unit {
        get{
            let userDefaults = UserDefaults.standard
            if let value = userDefaults.value(forKey: "unit") as? String{
                return Unit(rawValue: value)!
                
            }
            return _selectedUnit
        }
        set{
            let userDefaults = UserDefaults.standard
            userDefaults.set(newValue.rawValue, forKey: "unit")
        }
    }
}
