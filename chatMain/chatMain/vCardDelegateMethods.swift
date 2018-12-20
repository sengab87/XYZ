//
//  vCardDelegateMethods.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/4/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import UserNotifications
import XMPPFramework

extension XMPPTest {
  
    func addVcard(username :XMPPJID)
    {
       
        vCard.fetchvCardTemp(for: username, ignoreStorage: false)
    }
    func sendVcard(ProfilePic: Data?)
    {
        let vCardElement = DDXMLElement(name: "vCard", xmlns: "vcard-temp")
        let vCardTemp = XMPPvCardTemp.vCardTemp(from: vCardElement)
        vCardTemp.nickname = self.userJIDString
        vCardTemp.jid = XMPPJID(string: self.userJIDString + "@" + self.host)
        vCardTemp.photo = ProfilePic
        self.vCard.updateMyvCardTemp(vCardTemp)
    }
    
    /////////// Delegate Methods For vCard ////////////////
    ///////////// vcard delegate methods ////////////////////////////////////////
    func xmppvCardTempModule(_ vCardTempModule: XMPPvCardTempModule, didReceivevCardTemp vCardTemp:
        XMPPvCardTemp, for jid: XMPPJID) {
        print(vCardTemp.nickname)
        
        
    }
    func xmppvCardTempModule(_ vCardTempModule: XMPPvCardTempModule, failedToFetchvCardFor jid: XMPPJID, error: DDXMLElement?) {
        //print("failure")
        //print(jid)
        //print(vCardTempModule)
        
    }
    func xmppvCardTempModule(_ vCardTempModule: XMPPvCardTempModule, failedToUpdateMyvCard error: DDXMLElement?) {
        //// needs to be tested ////
        
        //self.vcardProfilePicDelegate?.vCardPhotoSent!(value: false)
    }
    func xmppvCardTempModuleDidUpdateMyvCard(_ vCardTempModule: XMPPvCardTempModule) {
        //print("vcardTest")
        //print(vCardTempModule)
        /*print(vCardTempModule)
         UserDefaults.standard.set(true, forKey: "vCardStatus")
         self.vcardProfilePicDelegate?.vCardPhotoSent!(value: true)*/
        
        
    }
}
