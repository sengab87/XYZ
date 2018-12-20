//
//  ViewController.swift
//  Generics
//
//  Created by Ahmed Sengab on 12/13/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//
/**
 New collection called the stack push and pop and the end
 */
import UIKit
struct planet {
    var a : Int
    var b : Int
}

/**
 Non generic type of struct
 */
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

/**
 Generic Struct
 */
struct Stack<T> {
    var items = [T]()
    mutating func push(_ item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}
extension Stack {
    var topItem: T? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}



class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var test = Stack<String>()
        
        //test.push("c")
        //print(test)
        print(test.topItem)
        var intOfTypeArray : Array<Int> = [1,2,3]
        var planet1 = planet(a: 5, b: 2)
        var planet2 = planet(a: 2, b: 1)
        print(planet1,planet2)
        swapTwoValues(&planet1, &planet2)
        print(planet1,planet2)
    }
    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    /**
     Non generic type constraint
     */
    func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    /**
     generic type constraint
     */
    func findIndex<T:Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
    if value == valueToFind {
    return index
    }
    }
    return nil
    }
    
}

