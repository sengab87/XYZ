//
//  xmppMessagingDelegateMethods.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/7/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import XMPPFramework

extension XMPPTest{
    
    func xmppStream(_ sender: XMPPStream, didSend message: XMPPMessage) {
        print("sent message")
    }
    func xmppStream(_ sender: XMPPStream, didFailToSend message: XMPPMessage, error: Error) {
        //print(error)
    }
    
    func sendMessage(user: String, messagetype:String, message:String)
    {
        
    }
    
    func xmppStream(_ sender: XMPPStream, didReceive message: XMPPMessage) {
    }
    
}
