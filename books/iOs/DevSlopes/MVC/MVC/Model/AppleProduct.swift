//
//  AppleProduct.swift
//  MVC
//
//  Created by Ahmed Sengab on 12/20/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
class AppleProduct{
     private (set) public var name : String
     private (set)public var color :String
     private (set) public var price : Double
    init(name: String, color: String, price: Double)
    {
        self.name = name
        self.color = color
        self.price = price
    }
}

