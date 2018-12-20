//
//  ViewController.swift
//  delegateTest
//
//  Created by Ahmed Sengab on 9/4/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, mainProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        Test.shared.delegate = self
        Test.shared.testHere()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setStatus(status: Bool) {
        if (status == true)
        {
            print("yes")
        }
    }

}

