//
//  ViewController.swift
//  final
//
//  Created by Dina Maala on 5/18/18.
//  Copyright © 2018 Dina Maala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //// set intial codes and country name ///
        UserDefaults.standard.set("United Stated", forKey: "countryName")
        UserDefaults.standard.set("1", forKey: "countryCode")
        //////////////////////////////////////////////////
        
        
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

