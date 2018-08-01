//
//  emailViewController.swift
//  final
//
//  Created by Dina Maala on 5/27/18.
//  Copyright © 2018 Dina Maala. All rights reserved.
//

import UIKit

class emailViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.goButton.layer.cornerRadius = 46/2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        goButton.isEnabled = true
        goButton.alpha = 1
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
