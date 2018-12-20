//
//  lastActivityDelegate.swift
//  chatMain
//
//  Created by Ahmed Sengab on 12/6/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import XMPPFramework
extension XMPPTest {
    func xmppLastActivity(_ sender: XMPPLastActivity!, didReceiveResponse response: XMPPIQ!) {
        print(response,"response")
    }
    func numberOfIdleTimeSeconds(for sender: XMPPLastActivity!, queryIQ iq: XMPPIQ!, currentIdleTimeSeconds idleSeconds: UInt) -> UInt {
        print(sender,"response1")
        print(iq,"respose2")
        print(idleSeconds,"response3")
        return 1
    }
    func xmppLastActivity(_ sender: XMPPLastActivity!, didNotReceiveResponse queryID: String!, dueToTimeout timeout: TimeInterval) {
        print(queryID,"response4")
        print(timeout,"respose5")
    }
}
