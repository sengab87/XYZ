//
//  File.swift
//  MVVM
//
//  Created by Ahmed Sengab on 5/31/21.
//

import Foundation

struct Restaurant: Decodable {
    let name: String
    let cusisine: Cuisine
}
enum Cuisine:String, Decodable {
    case europe
    case french
    case indian
    case mexican
}
