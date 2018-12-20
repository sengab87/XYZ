//
//  WeatherListViewModel.swift
//  MVVM_udemy
//
//  Created by Ahmed Sengab on 12/14/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
struct WeatherListViewModel{
    
    /// - Since weatherModels is private nothing can be done to that array outside of file
    /// * Adding two functions modify that weatherModels array
    
    private var weatherModels = [WeatherModel]()
    mutating func addWeatherViewModel(_ vm: WeatherModel)
    {
        self.weatherModels.append(vm)
    }
    func numberOfRows() ->Int
    {
        return self.weatherModels.count
    }
    func modelAt(_ index: Int) -> WeatherModel
    {
        return self.weatherModels[index]
    }
    mutating private func toCelsius()
    {
        weatherModels = weatherModels.map { (vm) in
            var weatherModel = vm
            weatherModel.currentTemperature.temperature =  (weatherModel.currentTemperature.temperature - 32 ) * 5/9
            return weatherModel
        }
    }
    mutating private func toFahrenheit()
    {
        weatherModels = weatherModels.map { (vm) in
            var weatherModel = vm
            weatherModel.currentTemperature.temperature =  (weatherModel.currentTemperature.temperature * 9 / 5 ) + 32
            return weatherModel
        }
    }
    mutating func updateUnit(to unit: Unit)
    {
        switch  unit {
        case .celsius:
            self.toCelsius()
        case .fahrenheit:
            self.toFahrenheit()
        }
    }
}
