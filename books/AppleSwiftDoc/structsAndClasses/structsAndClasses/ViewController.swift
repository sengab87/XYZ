//
//  ViewController.swift
//  structsAndClasses
//
//  Created by Ahmed Sengab on 12/13/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
/*Structs and enums are value types while classes are reference types*/
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let someResolution = Resolution()
        let someVideoMode = VideoMode()
        someVideoMode.resolution.width = 1280
        let vga = Resolution(width: 640, height: 480)
        let hd = Resolution(width: 1920, height: 1080)
        var cinema = hd
        cinema.width = 2048
        
        var Direction = CompassPoint.west
        let remeber = Direction
        Direction.turnNorth()
        
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        
        print(tenEighty.frameRate)

        
    }


}

