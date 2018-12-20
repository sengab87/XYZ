//
//  AddWeatherDelegate.swift
//  MVVM_udemy
//
//  Created by Ahmed Sengab on 12/14/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
protocol AddWeatherDelegate : AnyObject{
    func addWeatherDidSave(vm: WeatherModel)
}
protocol settingsDelegate : AnyObject {
    func settingsDone(vm: SettingsViewModel)
}
