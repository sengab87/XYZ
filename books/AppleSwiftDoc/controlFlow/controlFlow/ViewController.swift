//
//  ViewController.swift
//  controlFlow
//
//  Created by Ahmed Sengab on 12/12/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let somePoint = (0,0)
        switch somePoint
        {
        case(0,0):
            print("\(somePoint) is at the origins")
        case(_,0):
            print("\(somePoint) is on the y_axis")
        case(0,_):
            print("\(somePoint) is on the x_axis")
        case(-2...2,-2...2):
            print("\(somePoint) is in the box")
        default:
            print("\(somePoint) is out of the bax")
        }
        
        let someCharacter : Character = "z"
        switch someCharacter {
        case "a":
            print("a")
        case "z":
            print("z")
        default:
            print("yo")
        }
        
        /**
         For loop iterate
         */
        let base = 3
        let power = 10
        var answer = 1
        for _ in 1...power
        {
            answer *= base
            
        }
        print(base)
        /**
         Range Operators
         */
        let minutes = 5
        for index in 0..<minutes
        {
            print(index)
        }
        /**
         Print loop every 5
         */
        let range = 5
        for tickMark in stride(from: 0, to: 60, by: minutes){
            print(tickMark)
        }
        let final = ["Ahmed","sengab","mostafa","dina"]
        final.forEach { (word) in
            print(word)
        }
        
        /**
         While loop keep running until a condition is evaluated as false
         */
        let finalSquare = 25
        var board = [Int](repeating: 0, count: finalSquare+1)
        
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

        var square = 0
        var diceRoll = 0
        
        while diceRoll < finalSquare
        {
            if diceRoll == 7
            {
                diceRoll = 1
                
            }
            square += diceRoll
            if square < board.count {
                square += board[square]
            }
        }
        
        /**
         Repeat while is like do while
         */
        
        /**
         tuples
         */
        /**
         fallthrough continue execution to next cases
         */
        /**
         guard must be true for code to be exectued
         */
    }
}

