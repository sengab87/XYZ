//
//  ViewController.swift
//  MVC
//
//  Created by Ahmed Sengab on 12/20/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class Controller: UIViewController {

    @IBOutlet weak var iphonePriceLabel: UILabel!
    @IBOutlet weak var iphoneColorLabel: UILabel!
    @IBOutlet weak var iphoneNameLabel: UILabel!
    override func viewDidLoad() {
        

        super.viewDidLoad()
        let appleProduct = AppleProduct(name: "iPhoneX", color: "Space grey", price: 999.99)
        iphoneNameLabel.text = appleProduct.name
        iphoneColorLabel.text = appleProduct.color
        iphonePriceLabel.text = "\(appleProduct.price)"
        // Do any additional setup after loading the view, typically from a nib.
    }


}

