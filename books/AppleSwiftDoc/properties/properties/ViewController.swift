//
//  ViewController.swift
//  properties
//
//  Created by Ahmed Sengab on 12/13/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//
/// Static doesnot need intilization and they cant be overriden ///
import UIKit
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
struct cell{
    static var me = "test"
    var plead : Int
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    static func testing(){
        print("yo")
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            print(centerX,centerY,"here1")
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
            print(newValue.x,newValue.y,"here2")
            print(origin.x,origin.y,"here3")

        }
    }
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var square = Rect(origin: Point(x: 0, y: 0), size: Size(width: 10, height: 10))
        let initialSquareCenter = square.center // getting //
        square.center = Point(x: 15, y: 15)
        //square.center = Point(x: 15.0, y: 15.0)
        //print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        // Prints "square.origin is now at (10.0, 10.0)"
        
        print(SomeStructure.storedTypeProperty)
        // Prints "Some value."
        SomeStructure.storedTypeProperty = "Another value."
        print(SomeStructure.storedTypeProperty)
        // Prints "Another value."
        print(SomeEnumeration.computedTypeProperty)
        // Prints "6"
        print(SomeClass.computedTypeProperty)
        print(SomeClass.overrideableComputedTypeProperty)
        var p = cell(plead: 5)
        print(p.plead)
        print(cell.me)
        SomeClass.testing()
        
        // Prints "27"

    }


}

