//
//  xmppReconnectDelegateMethods.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/7/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import XMPPFramework

extension XMPPTest{
    func xmppReconnect(_ sender: XMPPReconnect, didDetectAccidentalDisconnect connectionFlags: SCNetworkConnectionFlags) {
        print("error1")
    }
    func xmppReconnect(_ sender: XMPPReconnect, shouldAttemptAutoReconnect connectionFlags: SCNetworkConnectionFlags) -> Bool {
        print("error2")
        return true
    }
}
