//
//  Wage.swift
//  WindowShopper
//
//  Created by Ahmed Sengab on 12/18/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation

// Pro tip:-
// Functions that depends on functions are bad

class Wage{
    class func getHours(forWage wage: Double, andPrince price: Double) -> Int{
        //return Int(round((price/wage)))
        return Int(ceil(price/wage))
    }
}
