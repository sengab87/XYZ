//
//  OnboardingPageVC.swift
//  BoardToDeath
//
//  Created by Caleb Stultz on 1/15/18.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import UIKit

class OnboardingPageVC: UIViewController {

    var userDefaults = UserDefaults.standard
        
    @IBAction func doneBtnWasPressed(_ sender: Any) {
        /*let alert = UIAlertController(title: "You did it!", message: "Congratulations, you survived our onboarding experience", preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: nil)
        alert.addAction(action)
        alert.view.accessibilityIdentifier = "Alert"
        self.present(alert,animated: true,completion: nil)*/
        userDefaults.onboardingCompleted = true
        dismiss(animated: true)
    }
    
}
