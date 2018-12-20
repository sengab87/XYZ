//
//  rosterDelegateMethods.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/5/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import Foundation
import UserNotifications
import XMPPFramework

extension XMPPTest  {
    func addUserToRoster(username:XMPPJID, nick:String)
    {
        self.roster.addUser(username, withNickname: nick)
        self.roster.acceptPresenceSubscriptionRequest(from: username, andAddToRoster: true)
    }
    /////////////////////////Roster Delegate Methods //////////////////////////////
    
    func xmppRosterDidEndPopulating(_ sender: XMPPRoster) {


        print("tttg")
        let  p = RosterMainViewController()
        p.determineChangeInContactStore()

        //RosterViewController.alert.dismiss(animated: true, completion: nil)
     /* let result = UserDefaults.standard.object(forKey: "firstRoster")
        if (result == nil)
        {
            UserDefaults.standard.set("done", forKey: "firstRoster")
            RosterViewController.alert.dismiss(animated: true, completion: nil)
        }*/
    }
    func xmppRoster(_ sender: XMPPRoster, didReceiveRosterPush iq: XMPPIQ) {
        
        print("t1")
        print(sender)
        print(iq)
        if let from = iq.from?.bare
        {
            DispatchQueue.main.async {
                let context = CoreDataStack(modelName: "contactsStore")
                let fetchRequest : NSFetchRequest<Contacts> = Contacts.fetchRequest()
                let sortDescriptor = NSSortDescriptor(key: #keyPath(Contacts.number), ascending: true)
                fetchRequest.sortDescriptors = [sortDescriptor]
                var planet : [String] = []
                do {
                    let final = try context.managedContext.fetch(fetchRequest)
                    planet = final.map {$0.number!}
                    print(planet,"planet")
                    if planet.contains(from)
                    {
                        print(from,"from")
                        XMPPTest.shared.addUserToRoster(username: XMPPJID(string: from)!, nick:from)
                        XMPPTest.shared.roster.acceptPresenceSubscriptionRequest(from:XMPPJID(string: from)!, andAddToRoster: true)
                    }
                }
                catch {
                    print("couldnot")
                }
            
            }
        }
        
        
    }
    func xmppRoster(_ sender: XMPPRoster, didReceiveRosterItem item: DDXMLElement) {
        print("t2")
         print(item)
         print(sender)
    }
    func xmppRosterDidBeginPopulating(_ sender: XMPPRoster, withVersion version: String) {
        print("t3")
        print(sender)
        
    }
    func xmppRoster(_ sender: XMPPRoster, didReceivePresenceSubscriptionRequest presence: XMPPPresence) {
        print("presence sub")
        print(presence)
        print(presence.fromStr as Any)
        
        let nec = presence.from?.bare.split(separator: "@")
        print(String(nec![0]))
        let user = RosterMainViewController()
        let context = user.coreDataStack.managedContext
        let fetchRequest : NSFetchRequest<Contacts> = Contacts.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Contacts.number), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let planet : [String] = []
        do {
            let final = try context.fetch(fetchRequest)
            let planet = final.map {$0.number}
            print(planet,"planet")
            if planet.contains(String(nec![0]))
            {
                XMPPTest.shared.addUserToRoster(username: (presence.from?.bareJID)!, nick:String(nec![0]))
            }
        }
        catch {
            print("couldnot")
        }
        print(planet,"number")
        /*if number!.contains(String(nec![0]))
        {
            print("hello123")
            XMPPTest.shared.addUserToRoster(username: (presence.from?.bareJID)!, nick:String(nec![0]))
        }*/
        
        
        
    }
}
