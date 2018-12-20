//
//  ViewController.swift
//  intialization
//
//  Created by Ahmed Sengab on 12/13/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit


/**
 One intialzation method
 */

/**
 Another Intialzation Method
 */
struct Celsius {
    var temperature : Double = 32 * 5/9
}
struct Fahrenheit{
    var temperature : Double
        init() {
            temperature = 32
    }
}
/**
 Another Form of Intialzation
 */
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
    init(_ redMode: Double) {
        self.red = redMode
        self.blue = redMode
        self.green = redMode
    }
}
/**
 Another Form of Intialzation
 */
struct CelsiusFahrenheit{
    var temperature: Double
    init(temperature fromFahrenheit: Double)
    {
        self.temperature = fromFahrenheit
    }
}
/**
 optional properties
 */
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
class SurveyQuestion1 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
/**
 - important: Default intializer case default can change if it is var
 */
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
/**
 struct with zero init
 */
struct Rect{
    var width : Double = 7.0
    var height : Double = 7.0
}

/// Intializer Delegation for value types. Call intizalizer to intialize other parts
/// Intializer Delegation  is allowed only for structs and enums. Structs and enums
/// Dont support inheritance. value types use self.init to refer to other initilazer of
/// same value type. If you define an intialzier for a value type you cant use default
///

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct RectBox
{
    var origin = Point()
    var size = Size()
    init(){
    }
    init(origin: Point, size: Size)
    {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size)
    {
        let originX = center.x - size.width/2
        let originY = center.y - size.height/2
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}


/// designated initializers and convenience initializers are for Classes
/// Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.
///
/// Designated initalizers must delegate superclass
/// Convienienc initalizers must delegate across the class
/// Class initialization in Swift is a two-phase process. In the first phase, each stored property is assigned an initial value by the class that introduced it. Once the initial state for every stored property has been determined, the second phase begins, and each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.

/// - important: SafetyCheck1                                                                               A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.
///  Check1 in breif it creates class and introduce properties and intilization before it send superclass intializer

/// - important: SafetyCheck2     A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.
/// Check2 in brief a designated intializer delegate to superclass before assigning value to an inherited property

/// - important: SafetyCheck3    A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.

/// - important: SafetyCheck4      An initializer cannot call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.

/// - important: How two phase initialization works
/**
      - A designated or convenience initializer is called on a class.
        Memory for a new instance of that class is allocated. The memory is not yet initialized.
 
      - A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
 
      - The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
 
      - This continues up the class inheritance chain until the top of the chain is reached.
 
      - Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.
 
    /// Phase2
 
    - Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
 
    - Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.

 */


/**
 Class Example
 */

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}
/**
 class Intialization
 */
class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // super.init() implicitly called here
        super.init()
    }
    override var description: String {
        return "\(description) in a beautiful \(color)"
    }
}
/**
 Failable intializers
 */
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        let ani = Animal(species:"")
        if ani == nil {
            
            print("to")
        }
        super.viewDidLoad()
        let hover = Hoverboard(color: "red")
        print(hover.numberOfWheels)
        let vehicle = Vehicle()
        vehicle.description
        //// Init ////
        let temp = Fahrenheit()
        print(temp.temperature)
        
        let tempcel = Celsius()
        print(tempcel.temperature)
        
        let tempCelFahr = CelsiusFahrenheit(temperature: 5)
        print(tempCelFahr.temperature)
        
        let color = Color(red: 1, green: 1, blue: 1)
        print(color.blue)
        
        let whiteColor = Color(white: 1)
        print(whiteColor.red)
        print(whiteColor.blue)
        
        let dashColor = Color(5)
        print(dashColor.blue)
        
        let survery = SurveyQuestion(text: "adeek")
        survery.response = "Yest"
        print(survery.response)
        
        let constSurvey = SurveyQuestion1(text: "adeek2")
        print(constSurvey.text)
        
        let shopping = ShoppingListItem()
        print(shopping.purchased)
        shopping.purchased = true
        print(shopping.purchased)
        
        let shape = Rect(width: 15, height: 15)
        print(shape.width)
        
        let basicRect = RectBox()
        print(basicRect.origin.x)
        print(basicRect.origin.y)
        print(basicRect.size.width)
        print(basicRect.size.height)
        
        let secondRect = RectBox(center: Point(x: 5, y: 5), size: Size(width: 10, height: 10))
        print(secondRect.origin.x)
        print(secondRect.origin.y)
        print(secondRect.size.width)
        print(secondRect.size.height)
        
        let thirdRect = RectBox(origin: Point(x: 0, y: 0), size: Size(width: 10, height: 10))
        print(thirdRect.origin.x)
        print(thirdRect.origin.y)
        print(thirdRect.size.width)
        print(thirdRect.size.height)

    }

}

