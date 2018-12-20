//
//  profileViewController.swift
//  chatMain
//
//  Created by Ahmed Sengab on 9/18/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class profileViewController: connectionStatus,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var profileImageView: UIView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    override func viewDidLoad() {
         super.viewDidLoad()
       
        // profileImageView.backgroundColor = UIColor.green
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ////// If we touch the country view we go to country ////////
    
        if let firstTouch = touches.first {
            print("tt")
            let hitView = self.view.hitTest(firstTouch.location(in: self.view), with: event)
            if (hitView == profileImageView)
            {
                print("here")
                self.performSegue(withIdentifier: "image", sender: self)
                
            }
      }
    }
    

}
