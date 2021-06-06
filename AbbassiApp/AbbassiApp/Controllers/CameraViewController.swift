//
//  CameraViewController.swift
//  AbbassiApp
//
//  Created by Ahmed Sengab on 5/9/21.
//

import UIKit
import Firebase
import AVFoundation

class CameraViewController: ConnectionStatusViewController{
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var DeviceIDLabel: UILabel!
    
    @IBOutlet weak var UserIDLabel: UILabel!
    override func viewWillDisappear(_ animated: Bool) {
        removeOverlay()
    }
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.EmailLabel.text = Auth.auth().currentUser?.email
        self.DeviceIDLabel.text = UIDevice.current.identifierForVendor?.uuidString
        self.UserIDLabel.text = Auth.auth().currentUser?.uid
    }
    
    @IBAction func cameraBtnPressed(_ sender: Any) {
        self.checkCameraStatus()
    }
    private func checkCameraStatus() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus{
            case .denied:
                self.presentCameraSettings()
            case .restricted:
                self.presentCameraSettings()
            case .authorized:
                DispatchQueue.main.async{
                    self.performSegue(withIdentifier: "Vision", sender: nil)
                }
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { success in
                    if success {
                        DispatchQueue.main.async{
                            self.performSegue(withIdentifier: "Vision", sender: nil)
                        }
                    } else {
                        
                    }
                }
        }
    }
    
    private func presentCameraSettings() {
        let alertController = UIAlertController(title: "Camera access request",
                                      message: "Camera access is denied",
                                      preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })

        present(alertController, animated: true)
    }
}

