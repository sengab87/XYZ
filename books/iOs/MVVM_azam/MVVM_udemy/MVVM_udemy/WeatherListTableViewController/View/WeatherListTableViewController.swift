//
//  WeatherListTableViewController.swift
//  MVVM_udemy
//
//  Created by Ahmed Sengab on 12/13/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import UIKit
class WeatherListTableViewController : UITableViewController, AddWeatherDelegate,settingsDelegate{
    
    
    
    private var weatherModel = WeatherListViewModel()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherModel.numberOfRows()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let weatherVM = self.weatherModel.modelAt(indexPath.row)
        
        cell.configure(weatherVM)
        return cell
    }
    func addWeatherDidSave(vm: WeatherModel) {
        self.weatherModel.addWeatherViewModel(vm)
        self.tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddWeatherCitySegue")
        {
            prepareforAddWeatherCityViewControllerSegue(segue: segue)
        }
        else if (segue.identifier == "WeatherDetails")
        {
            
        }
        else{
           prepareforSettingsViewControllerSegue(segue: segue)
        }
    }
    private func prepareforAddWeatherCityViewControllerSegue(segue: UIStoryboardSegue)
    {
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("nav controller not found")
        }
        guard let addAnotherCityViewController = nav.viewControllers.first as? AddWeatherCityViewController else {
            fatalError("Add weather viewController failed ")
        }
        addAnotherCityViewController.delegate = self
    }
     private func prepareforSettingsViewControllerSegue(segue: UIStoryboardSegue)
     {
        guard let nav = segue.destination as? UINavigationController else {
        fatalError("nav controller not found")
        }
        guard let settingsViewController = nav.viewControllers.first as? SettingsTableViewController else {
        fatalError("Settings viewController failed ")
        }
        settingsViewController.delegate = self
    }
    func settingsDone(vm: SettingsViewModel) {
        self.weatherModel.updateUnit(to: vm.selectedUnit)
        self.tableView.reloadData()
    }
}
