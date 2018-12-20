//
//  mainProtocol.swift
//  chatMain
//
//  Created by Ahmed Sengab on 9/4/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//



import Foundation

@objc protocol mainProtocol {
    @objc optional func userRegisterStatus(value: Bool)
    @objc optional func authenticationStatus(value: Bool)
    @objc optional func newContactIsAdded(firstName: String?, LastName: String?, phoneOne: String?, phoneTwo : String?, phoneThree: String?)
    @objc optional func myPresenceStatus(value:Bool)
    @objc optional func myvCardisUpdated(value: Bool)
    @objc optional func userName(intials: String, name:String)
    @objc optional func vCardPhotoSent(value: Bool)
}

