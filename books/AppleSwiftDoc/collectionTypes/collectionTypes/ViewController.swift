//
//  ViewController.swift
//  collectionTypes
//
//  Created by Ahmed Sengab on 12/12/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /*
     Arrays are an ordered collection of values
     set are an unorderd of unique values
     Dictionaries are unordered collection of key-value storage
     Var vs let are mutable vs immutable
     */
    override func viewDidLoad() {
        super.viewDidLoad()
    /**
         -parameters :
         - An Array stores a value of same type in ordered list
         Array<Element> Element is the type [Element]
    */
        /**
         - important: An array of Int  empty value
         */

        let array  = [Int]()
        /**
         - Remark: repeating Array of type int
        */
        let repeatingArray = Array(repeating: 0, count: 3)
        let anotherArray : [String] = []
        var ExampleArray = ["Ahmed", "Mostafa","Selim", "Dina"]
        /**
         print(1..3)
        */
        /**
         insert and remove items in an Array
         */
        print(ExampleArray[1...3])
        ExampleArray.insert("p", at: ExampleArray.count)
        print(ExampleArray)
        ExampleArray.remove(at: 0)
        print(ExampleArray)
        
        /** looping over array */
        for index in ExampleArray
        {
            print(index)
        }
        /** looping over array and pring location */
        for (index,value) in ExampleArray.enumerated()
        {
            print(index,value)
        }
        /* Sets when order is not important and when it is unique
           to store an Item in a set the type must be hashable
           Enumrator vwithout values  are hashable
         */
        /* creating and Intializing an Empty set */
        var letters = Set<Character>()
        letters.insert("a")
        letters.insert("a")
        print(letters.count)
        
        /* Creating a set with an array literal */
        var favoriteGeneres : Set<String> = ["Ahmed" , "Selim", "Mostafa","Sengab"]
        for index in favoriteGeneres{
            print(index)
        }
        favoriteGeneres.remove("Ahmed")
        print(favoriteGeneres.count)
        if (favoriteGeneres.contains("Selim"))
        {
            print("here")
        }
        for genere in favoriteGeneres.sorted()
        {
            print(genere)
        }
        /**
         Set operations
         */
        let oddDigits : Set = [1,3,5,7,9]
        let evenDigist : Set = [0,2,4,6,8]
        let singleDigitPrimeNumbers : Set = [2,3,5,7]
        let union = oddDigits.union(evenDigist).sorted()
        let intersection = oddDigits.intersection(singleDigitPrimeNumbers).sorted()
        let symmetricDifference = oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
        let subtraction = oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
        print(subtraction)
        print(symmetricDifference)
        print(union)
        print(intersection)
        
        
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]
        
        let statusH = houseAnimals.isSubset(of: farmAnimals)
        print(statusH)
        let statusF = farmAnimals.isSuperset(of: houseAnimals)
        print(statusF)
        let statusC = farmAnimals.isDisjoint(with: cityAnimals)
        print(statusC)
        
        /**
         Dictionaries must conform to hashable protocol
         */
        
        /**
         Creating and empty dictionary [key:value]
         */
        var nameOfIntegers : [Int:String] = [:]
        nameOfIntegers[16] = "Sixteen"
        nameOfIntegers[16] = "Value"
        print(nameOfIntegers.values)
        
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        airports.updateValue("zobr", forKey: "YYZ")
        print(airports.keys)
        
        for (key,value) in airports
        {
            print(key,value)
        }
        
        
        
        
        
        
        
    }
}

