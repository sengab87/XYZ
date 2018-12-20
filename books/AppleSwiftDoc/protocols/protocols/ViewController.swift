//
//  ViewController.swift
//  protocols
//
//  Created by Ahmed Sengab on 12/13/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
protocol FullyNamed {
    var fullName: String { get }
}
struct Person: FullyNamed {
    var last:String
    var fullName: String {
        get {
            return fullName
            
        }
    set {
            self.last = "sengab"
        }
    }
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var john = Person(last: "bo")
        john.fullName = "Ahmed"
        
        print(john.fullName)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

