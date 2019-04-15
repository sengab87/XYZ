//
//  FirstViewController.swift
//  IOTFit
//
//  Created by Ahmed Bakir on 2018/01/20.
//  Copyright © 2018 Ahmed Bakir. All rights reserved.
//

import UIKit
import CoreLocation

enum WorkoutState {
    case inactive
    case active
    case paused
}

class CreateWorkoutViewController: UIViewController {

    var currentWorkoutState = WorkoutState.inactive
    let locationManager = CLLocationManager()
    @IBOutlet weak var workoutTimeLabel : UILabel?
    @IBOutlet weak var workoutDistanceLabel : UILabel?
    
    @IBOutlet weak var toggleWorkoutButton : UIButton?
    @IBOutlet weak var pauseWorkoutButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

 
    
    @IBAction func toggleWorkout() {
        NSLog("Toggle workout button pressed")
        switch currentWorkoutState {
        case .active:
            currentWorkoutState = .inactive
        case .inactive:
            currentWorkoutState = .active
            requestPermission()
        case .paused:
            currentWorkoutState = .paused
            
        }
    }
    
    @IBAction func pauseWorkout() {
        NSLog("Pause workout button pressed")
    }
    func requestPermission() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.distanceFilter = 10.0
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse :
                requestAlwaysPermission()
            case .authorizedAlways:
                startWorkout()
            default:
                presentPermissionErrorAlert()
            }
        }
        else {
            //
            presentEnableLocationAlert()
        }
    }
    func presentEnableLocationAlert() {
        let alert = UIAlertController(title: "PermissionError", message: "Please enable location services on your device", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style:
            UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func requestAlwaysPermission() {
        if let isConfigured = UserDefaults.standard.value(forKey:
            "isConfigured") as? Bool, isConfigured == true {
            startWorkout()
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    func startWorkout() {
        currentWorkoutState = .active
        UserDefaults.standard.setValue(true, forKey:
            "isConfigured")
        UserDefaults.standard.synchronize()
        locationManager.startUpdatingLocation()
    }
    func presentPermissionErrorAlert() {
        let alert = UIAlertController(title: "Permission Error",
                                      message: "Please enable location services for this app",
                                      preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style:
            UIAlertAction.Style.default, handler: {
                (action:  UIAlertAction) in
                if let settingsUrl = URL(string:
                    UIApplication.openSettingsURLString),
                    UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl,
                                              options: [:], completionHandler: nil)
                }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style:
            UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
extension CreateWorkoutViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            requestAlwaysPermission()
        case .authorizedAlways:
            startWorkout()
        case .denied:
            presentPermissionErrorAlert()
        default:
            NSLog("Unhandled Location Manager Status:\(status)")
        }

    }
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else {
            NSLog("Unable to read most recent location")
            return
        }
        NSLog("Most recent location: \(String(describing:mostRecentLocation))")
    }
}

