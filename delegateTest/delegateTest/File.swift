//
//  File.swift
//  delegateTest
//
//  Created by Ahmed Sengab on 9/4/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
class Test:mainProtocol
{
    private init() {}
    let var1 = "ahmed"
    let var2 = "sengab"
    static let shared = Test()
    weak var delegate : mainProtocol?
    func testHere()
    {
        delegate?.setStatus!(status: true)
        print("yup")
    }
}

