//
//  APIError.swift
//  News
//
//  Created by Ahmed Sengab on 6/1/21.
//

import Foundation

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}
