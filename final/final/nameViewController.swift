//
//  nameViewController.swift
//  final
//
//  Created by Dina Maala on 5/27/18.
//  Copyright © 2018 Dina Maala. All rights reserved.
//

import UIKit

class nameViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var goButtonName: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.goButtonName.layer.cornerRadius = 46/2
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        if (lastName.text != nil)
        {
            if !((lastName.text?.isEmpty)!)
            {
                self.goButtonName.isEnabled = true
                self.goButtonName.alpha = 1
            }
            else
            {
                self.goButtonName.isEnabled = false
                self.goButtonName.alpha = 0.5
            }
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
