//
//  iQDelegateMethods.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/5/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import UserNotifications
import XMPPFramework

extension XMPPTest {
    func searchUsername(username : XMPPJID)
    {
        let user = username.bareJID.user
        let message = XMPPIQ(name: "iq")
        let server = self.stream.hostName
        let sub = user! + "@" + server!
        let test = "vjud.www.estore87.com"
        let uuid = self.stream.generateUUID
        let from = self.userJIDString + "@" + server!
        message.addAttribute(withName: "type", stringValue: "set")
        message.addAttribute(withName: "from", stringValue: from)
        message.addAttribute(withName: "to", stringValue: test)
        message.addAttribute(withName: "id", stringValue: uuid)
        message.addAttribute(withName: "xml:lang", stringValue: "en")
        let child = DDXMLElement(name: "query", xmlns: "jabber:iq:search")
        let child1 = DDXMLElement(name: "x", xmlns: "jabber:x:data")
        child1.addAttribute(withName: "type", stringValue: "submit")
        let child2 = DDXMLElement(name: "field")
        child2.addAttribute(withName: "var", stringValue: "user")
        let child3 = DDXMLElement(name: "value", stringValue: user!)
        
        child.addChild(child1)
        child1.addChild(child2)
        child2.addChild(child3)
        message.addChild(child as DDXMLNode)
        self.stream.send(message)
    }
    func xmppStream(_ sender: XMPPStream, didReceive iq: XMPPIQ) -> Bool {
        
        let iqString = iq.xmlString
        if iqString.contains("jabber:iq:search") && iqString.contains("reported") && iqString.contains("nick") && iqString.contains("item")
        {
            DispatchQueue.main.async{
                if (iq.isResultIQ)
                {
                    if let iqStanza = iq.childElement
                    {
                        if let queryStanza = iqStanza.child(at: 0)
                        {
                            if let dataStanza = queryStanza.child(at: 2)
                            {
                                if let jidStanza = dataStanza.child(at: 0)
                                {
                                    if let user = jidStanza.stringValue?.replacingOccurrences(of: "@www.estore87.com", with: "")
                                    {
                                            print(user,"userT")
                                        let finalUserJid = XMPPJID(string: user + "@" + self.stream.hostName!)
                                        if (finalUserJid != self.stream.myJID)
                                        {
                                            XMPPTest.shared.addUserToRoster(username: finalUserJid!, nick: user)
                                            XMPPTest.shared.addVcard(username:finalUserJid!)
                                            
                                        }
                                    }
                                    else{
                                     print("no")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return true
    }
}
