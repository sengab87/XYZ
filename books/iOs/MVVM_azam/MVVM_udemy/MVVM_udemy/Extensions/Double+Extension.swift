//
//  Double+Extension.swift
//  MVVM_udemy
//
//  Created by Ahmed Sengab on 12/14/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
extension Double {
    var formatAsDegree : String{
        return String(format: "%0.f°", self)
    }
}
