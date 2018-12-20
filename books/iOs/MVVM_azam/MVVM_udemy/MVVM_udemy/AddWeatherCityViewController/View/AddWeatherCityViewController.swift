//
//  AddWeatherCityViewController.swift
//  MVVM_udemy
//
//  Created by Ahmed Sengab on 12/13/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import UIKit

class AddWeatherCityViewController : UIViewController{
    
    private var currentCityViewModel = AddCityViewModel()
    var delegate : AddWeatherDelegate?
    /// cityNameText Field whill take city name input ///
    @IBOutlet weak var cityNameTextField : BindingTextField!{
        didSet{
            
            currentCityViewModel.city.bidirectionalBind(to: cityNameTextField.reactive.text)
       
            }
    }
    @IBOutlet weak var zipCodeTextField : BindingTextField!
        {
        didSet{
            currentCityViewModel.zip.bidirectionalBind(to: zipCodeTextField.reactive.text)
        }
    }
    @IBOutlet weak var stateTextField : BindingTextField!
        {
        didSet{
            currentCityViewModel.state.bidirectionalBind(to: stateTextField.reactive.text)
        
        }
    }
    /// - important: The function search temperature for a certain city name
    @IBAction func saveCityButtonPressed() {
    
        print(self.currentCityViewModel)
        if let city = cityNameTextField.text{
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=0d72314dc50e151cd58720dc389ef8fb&units=imperial")!
            let weatherResource = Resource<WeatherModel>(url: weatherURL){
                data in
                
                let weatherVM = try? JSONDecoder().decode(WeatherModel.self, from: data)
                return weatherVM // return T
            }
            Webservice().load(resource: weatherResource) { [weak self] (result) in
                
                if let weatherVM = result {
                    print("I am Currently testing")
                    if let delegate = self?.delegate {
                        print("I am Currently testing2")
                        delegate.addWeatherDidSave(vm: weatherVM)
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    /// - This function dismisses the addWeatherCityViewController
    @IBAction func close(){
        self.dismiss(animated: true, completion: nil)
    }
}
