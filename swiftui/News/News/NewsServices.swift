//
//  NewsServices.swift
//  News
//
//  Created by Ahmed Sengab on 6/1/21.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest {get}
    var baseUrl: URL {get}
    var path: String {get}
}
