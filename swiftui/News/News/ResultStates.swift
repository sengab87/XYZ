//
//  ResultStates.swift
//  News
//
//  Created by Ahmed Sengab on 6/1/21.
//

import Foundation
enum ResultStates {
    case loading
    case success(content: [Article])
    case failed(error: Error)
}
