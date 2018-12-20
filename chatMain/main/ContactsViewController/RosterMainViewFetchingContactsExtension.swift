//
//  RosterMainViewFetchingContactsExtension.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/10/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import UIKit
import Contacts
import UserNotifications
import XMPPFramework

extension RosterMainViewController{
    func fetchContacts(completion: () -> ())
    {
        
        print("in fetch Contacts")
        let allowedCharset = CharacterSet
            .decimalDigits
        ///// after we get access to fetch contacts //// we reload table view data ///
        let keys = [CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactFamilyNameKey,CNContactMiddleNameKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
                let array = contact.phoneNumbers
                for number in array
                {
                    let fullName = contact.givenName + contact.middleName
                    let lastName = contact.familyName
                    let value = number.value.stringValue
                    let number = String(value.unicodeScalars.filter(allowedCharset.contains))
                    
                    if (fullName != "SPAM")
                    {
                        
                        self.firstName.append(fullName)
                        self.lastName.append(lastName)
                        self.numberArray.append(number)
                    }
                }
                
            })
            completion()
        }
        catch let err2 {
            print ("failer to enurmerate",err2)
        }
    }
    func tableSettings()
    {
        print("tableSettings")
        DispatchQueue.main.async {
            let count = self.numberArray.count - 1
            for i in 0...count
            {
                let contact = Contacts(context: self.coreDataStack.managedContext)
                contact.first = self.firstName[i]
                contact.last = self.lastName[i]
                contact.number = self.numberArray[i]
                contact.status = true
            }
            do {
                try self.coreDataStack.managedContext.save()
                self.coreDataSave = true
            }
            catch let err {
                print("couldnot save contacts \(err)")
            }
        }
    }
    
}
