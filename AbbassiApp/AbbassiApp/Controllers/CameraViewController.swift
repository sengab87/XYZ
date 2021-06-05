//
//  CameraViewController.swift
//  AbbassiApp
//
//  Created by Ahmed Sengab on 5/9/21.
//

import UIKit
import Firebase
import SPPermissions

class CameraViewController: ConnectionStatusViewController ,SPPermissionsDelegate{
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
        let authStatus = SPPermissions.Permission.camera.authorized
        if (authStatus){
            addTranstion()
            self.performSegue(withIdentifier: "Vision", sender: nil)
        } else {
            let permissions: [SPPermissions.Permission] = [.camera]
            let controller = SPPermissions.dialog(permissions)
            controller.delegate = self
            controller.present(on: self)
            let authorized = SPPermissions.Permission.camera.authorized
            if (authorized){
                addTranstion()
                self.performSegue(withIdentifier: "Vision", sender: nil)
            }
            
        }
        func didAllowPermission(_ permission: SPPermissions.Permission) {
            self.performSegue(withIdentifier: "Vision", sender: nil)
        }
    }
}

