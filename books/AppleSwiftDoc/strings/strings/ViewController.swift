//
//  ViewController.swift
//  strings
//
//  Created by Ahmed Sengab on 12/12/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    /// Substrings /////
        
        //// End Index cant be used because it is out of range /////
        let greeting = "Hello, World"
        let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
        //let final = greeting.endIndex
        print(index)
        let beginning = greeting[..<index]
        let newString = String(beginning)
        let testing = "Hello: Test"
        if testing.hasPrefix("Hello"){
            print("pre")
        }
        if testing.hasSuffix("Test")
        {
            print("suffix")
        }
        print(newString)
    }


}

