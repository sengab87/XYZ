//
//  ViewController.swift
//  closures
//
//  Created by Ahmed Sengab on 12/12/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    
    var x = 10
    func doSomething() {
        
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}




class ViewController: UIViewController {

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let instance = SomeClass()
        instance.doSomething()
        print(instance.x)
        
        
        completionHandlers.first!()
        print(instance.x)
        /**
         Closure Types
         - Global Functions: are closure that have name and do not capture any values
         - Nested Functions: are closures that a name and capture values from their enclosing functions
         - Closure Expressions: are unnamed closures written in lightweight syntax that can capture values from their surrounding context
         */
        /**
         Swift’s closure expressions have a clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios. These optimizations include:
         
         - Inferring parameter and return value types from context
         - Implicit returns from single-expression closures
         - Shorthand argument names
         - Trailing closure syntax

         */
         /**
         closure syntax {(input Parameters)->(returntype) in
         code
         }
         in starts closure body
         }
         */
        /**
         A closure is said to escape a function when a closure is passed to function as
         an argument but is called after a function is returned
         */
        
        
        
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        var result = names.sorted(by: backwards)
        var reversedNames = names.sorted { (s1, s2) -> Bool in
            return s1>s2
        }
        /**
         if closure is passed as arguments it can infer types
         */
        var reversedNames1 = names.sorted {  s1, s2   in return s1>s2 }
        var reversedNames2 = names.sorted {  s1, s2   in  s1>s2 }
        var reversedNames3 = names.sorted {  $0>$1 } // $0 and $1 are closure arguments
        var reversedNames4 = names.sorted(by: >)
        
        /**
          Trailing closures are passed to functions as functions final argument
         */



        print(reversedNames)
        print(result)
        /// calling function with closure
        someFunctionThatTakesAClosure { (s1, s2) in
            //return s1>s2
        }
        
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        
        /*someFunctionThatTakesAClosure() {
            // trailing closure's body goes here
        }*/
        /// This can be an inline or trailing closure ///
        let string = numbers.map() { (number) -> String in
            var number = number
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            return output
        }
        print(string)
        var p = 5
        var test = makeIncrementer(forIncrement: p)()
        print(test)
    }
    func makeIncrementer(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 7
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementer
    }
    func backwards(_ s1: String, _ s2: String) -> Bool
    {
        return s1>s2
    }
    /// Function that takes a closure
    func someFunctionThatTakesAClosure(closure: (_ s1:String, _ s2:String) -> Void) {
    // function body goes here
        print("†est")
    }
    /// If closure is only argument no need for ()

}

