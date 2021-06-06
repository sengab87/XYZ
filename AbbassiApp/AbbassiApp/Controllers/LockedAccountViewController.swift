//
//  LockedAccountViewController.swift
//  AbbassiApp
//
//  Created by Ahmed Sengab on 5/27/21.
//

import UIKit
import PMAlertController
import Firebase


class LockedAccountViewController: UIViewController {
   

    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
    }
    override func viewDidLoad() {
        super.viewDidLoad()


        UserDefaults.standard.setValue("locked", forKey: "account")
        let alertVC = PMAlertController(title: "Account Status", description: "Your Account Has Been locked due to violating terms and Conditions", image: #imageLiteral(resourceName: "stop_image"), style: .alert)
        
        alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
            do {
                try Auth.auth().signOut()
                UIControl().sendAction(#selector(NSXPCConnection.suspend),
                                       to: UIApplication.shared, for: nil)
                
            }catch let err{
                
            }
            
            
            })
        )
        self.present(alertVC, animated: true, completion: nil)
    }
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
