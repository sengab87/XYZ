//
//  ViewController.swift
//  functions
//
//  Created by Ahmed Sengab on 12/12/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testing(ahmed: "ahmed", sengab: "sengab")
        testing1(parameter: "ahmed1", parameter2: "sengab1")
        testing2("ahmed1", "sengab2")
        var b = 5
        var c = 6
        swap(a: &b, b: &c)
        swap1(parameter: &a, parameter2: &b)
        swap2(&b, &c)
        print(b,c)
        
    }
    func testing(ahmed parameter:String, sengab parameter2:String) ->()
    {
        print("\(parameter) is and 2 is \(parameter2)")
        
    }
    func testing1(parameter:String, parameter2:String) -> ()
    {
        print("\(parameter) is and 2 is \(parameter2)")
    }
    func testing2(_ parameter:String, _ parameter2:String) -> ()
    {
        
        print("\(parameter) is and 2 is \(parameter2)")
    }
    func swap(a parameter : inout Int, b parameter2 : inout Int)
    {
        let temperory = parameter
        parameter = parameter2
        parameter2 = temperory
    }
    func swap1(parameter : inout Int, parameter2 : inout Int)
    {
        let temperory = parameter
        parameter = parameter2
        parameter2 = temperory
    }
    func swap2(_ parameter : inout Int, _ parameter2 : inout Int)
    {
        let temperory = parameter
        parameter = parameter2
        parameter2 = temperory
    }


}

