//
//  WeatherCell.swift
//  MVVM_udemy
//
//  Created by Ahmed Sengab on 12/13/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
class WeatherCell : UITableViewCell
{
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
   
    func configure(_ vm: WeatherModel)
    {
        self.cityNameLabel.text = vm.name
        self.temperatureLabel.text = "\(vm.currentTemperature.temperature.formatAsDegree)"
    }
}
