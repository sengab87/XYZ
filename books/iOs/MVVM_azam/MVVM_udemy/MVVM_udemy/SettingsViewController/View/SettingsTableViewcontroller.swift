//
//  SettingsTableViewcontroller.swift
//  MVVM_udemy
//
//  Created by Ahmed Sengab on 12/14/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
class SettingsTableViewController : UITableViewController{
    private var settingsViewModel = SettingsViewModel()
    var delegate : settingsDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    @IBAction func doneButtonPressed()
    {
        if let delegate = self.delegate
        {
            delegate.settingsDone(vm: self.settingsViewModel)
        }
        self.dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.Units.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingsItem = self.settingsViewModel.Units[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        cell.textLabel?.text = settingsItem.displayName
        if (settingsItem == self.settingsViewModel.selectedUnit){
            cell.accessoryType = .checkmark
            
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.visibleCells.forEach { (cell) in
            cell.accessoryType = .none
        }
        if let cell = tableView.cellForRow(at: indexPath)
        {
            /// Uncheck all cell
            cell.accessoryType = .checkmark
            let unit = Unit.allCases[indexPath.row]
            self.settingsViewModel.selectedUnit = unit
        }
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath)
        {
            cell.accessoryType = .none
        }
    }
}
