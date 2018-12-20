//
//  presenceDelegateMethods.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/5/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import Foundation
import UserNotifications
import XMPPFramework

extension XMPPTest
{
    /////////////////////////////////////////////////////////////////////////////
    ///////////// Notification for delgates /////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////
    func xmppStream(_ sender: XMPPStream, didFailToSend presence: XMPPPresence, error: Error) {
        
    }
    func xmppStream(_ sender: XMPPStream, didSend presence: XMPPPresence) {
        
    }
    func xmppStream(_ sender: XMPPStream, didReceive presence: XMPPPresence) {
        print("recieving Presence")
        print(presence)
        if (presence.from?.bareJID == presence.to?.bareJID)
        {
            self.presenceDelegate?.myPresenceStatus!(value: true)
        }
    }
}
