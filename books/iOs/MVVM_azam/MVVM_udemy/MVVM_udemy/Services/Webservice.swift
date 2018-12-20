//
//  Webservice.swift
//  MVVM_udemy
//
//  Created by Ahmed Sengab on 12/14/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
/// - Generic type which will be substitied with concreter type
/// - two properties URL and parse closure which will parse return request
struct Resource<T>{
    let url : URL
    let parse : (Data) -> T?
    
}
/// - No class will inherit from the Webservice class
final class Webservice{
    /// -This function will call the weather for the specified city form the Weather api
    ///
    /// - Parameters:
    ///   - resource: resource in the struct with url
    ///   - completion: parse closure that will take type T and return nothin
    func load<T>(resource: Resource<T>, completion: @escaping (T?)->()){
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            print(data)
            if let data = data {
                /// Completions is fired on background thread
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            }
            else {
                completion(nil)
            }
        }.resume()
    }
}
