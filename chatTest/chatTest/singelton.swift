//
//  singelton.swift
//  xmppTut
//
//  Created by Ahmed Sengab on 7/30/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import UserNotifications
import XMPPFramework


class XMPPTest :NSObject, XMPPRosterDelegate, XMPPStreamDelegate, XMPPReconnectDelegate, XMPPvCardTempModuleDelegate, mainProtocol, XMPPLastActivityDelegate{
  
    let password = UserDefaults.standard.string(forKey: "password")
    let status = UserDefaults.standard.string(forKey: "status")
    let userJIDString = UserDefaults.standard.object(forKey: "username") as! String
    let stream = XMPPStream()
    let port = 5222
    let host = "www.estore87.com"
    let jid = XMPPJID()
    let reconnect = XMPPReconnect()
    var regDelegate : mainProtocol?
    var authDelegate : mainProtocol?
    var presenceDelegate : mainProtocol?
    var vcardDelegate : mainProtocol?
    var vcardProfilePicDelegate: mainProtocol?
    var rosterStorage : XMPPRosterCoreDataStorage!
    var roster : XMPPRoster!
    var vCardStorage :  XMPPvCardCoreDataStorage!
    var vCard : XMPPvCardTempModule!
    var lastactivity = XMPPLastActivity()
    static let shared = XMPPTest()
    
    override init()
    {
        print("teststream")
        super .init()
        //// Stream /////
        self.stream.hostName = host
        self.stream.hostPort = UInt16(port)
        self.stream.startTLSPolicy = XMPPStreamStartTLSPolicy.allowed
        self.stream.myJID = XMPPJID(string: userJIDString + "@" + host)
        self.stream.addDelegate(self, delegateQueue: .main)
        self.lastactivity.addDelegate(self, delegateQueue: .main)
        self.lastactivity.activate(self.stream)
        
        
        ///Reconnect ///////
        self.reconnect.addDelegate(self, delegateQueue:
            .main)
        self.reconnect.autoReconnect = true
        self.reconnect.activate(self.stream)
        
        /////// Roster /////////
        self.rosterStorage = XMPPRosterCoreDataStorage.sharedInstance()
        print(self.rosterStorage)
        self.roster = XMPPRoster(rosterStorage: self.rosterStorage)
        self.roster.activate(self.stream)
        self.roster.addDelegate(self, delegateQueue: .main)
        self.roster.autoAcceptKnownPresenceSubscriptionRequests = true
        self.roster.autoFetchRoster = true
        self.roster.autoClearAllUsersAndResources = false
        self.rosterStorage.autoRemovePreviousDatabaseFile = false
        
        
        //// Vcard /////
        self.vCardStorage = XMPPvCardCoreDataStorage.sharedInstance()
        self.vCard = XMPPvCardTempModule(vCardStorage: vCardStorage)
        self.vCard.activate(self.stream)
        self.vCard.addDelegate(self, delegateQueue: .main)
        ///////////////
    }
   
}


