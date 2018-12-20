//
//  xmppStreamAndRegistrationDelegate.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/7/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import XMPPFramework

extension XMPPTest{
    
    func connect()
    {
        
        do {
            try self.stream.connect(withTimeout: XMPPStreamTimeoutNone)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func registerUser()
    {
        
        let user = DDXMLElement.element(withName: "username", stringValue: userJIDString)
        let pass = DDXMLElement.element(withName: "password", stringValue: password!)
        let key = DDXMLNode.element(withName: "key", stringValue: "TEST3")
        print(user,key,pass)
        do {try self.stream.register(with: [user as! DDXMLElement, pass as! DDXMLElement, key as! DDXMLElement])}
        catch {print("Error")}
        
    }
    func xmppStreamDidConnect(_ sender: XMPPStream) {
        print("connected")
        
        if (status != nil)
        {
            do {try self.stream.authenticate(withPassword: password!)}
            catch{print("couldnot authenticated",error)}
        }
        
        //////////////////// Here we register with elements ///////////////////
    }
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        if (status != "registered")
        {
            UserDefaults.standard.set("registered", forKey: "status")
            
            
                print("in delegate")
                self.regDelegate?.userRegisterStatus!(value: true)

            
        }
        print("authenticated")
        self.stream.send(XMPPPresence())
        self.authDelegate?.authenticationStatus!(value: true)
    }
    
    func xmppStreamDidRegister(_ sender: XMPPStream) {
        do {
            try self.stream.authenticate(withPassword: password!)
        }
        catch{print("couldnot register",error)}
    }
    func xmppStreamDidDisconnect(_ sender: XMPPStream, withError error: Error?) {
        print("Disconneted")
        
    }
    func xmppStream(_ sender: XMPPStream, didNotRegister error: DDXMLElement) {
        print(error)
        
    }
}
