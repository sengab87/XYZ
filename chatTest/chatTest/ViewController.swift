//
//  ViewController.swift
//  chatTest
//
//  Created by Ahmed Sengab on 8/11/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
import XMPPFramework
import Contacts
class ViewController: UIViewController, XMPPRosterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        XMPPTest.shared.connect()
        XMPPTest.shared.testp()
        //fetchContacts()
       // testingPresence()
        //XMPPTest.shared.connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// function for fetching Contacts ////////////
    
    private func fetchContacts()
    {
        let allowedCharset = CharacterSet
            .decimalDigits
            .union(CharacterSet(charactersIn: "+"))
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, err) in
            if let error = err
            {
                print("failed to access",error)
                return
            }
            if (granted)
            {
                print("access granted")
                let keys = [CNContactGivenNameKey,CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
                        print(contact.givenName)
                        let array = contact.phoneNumbers
                        for number in array
                        {
                            let value = number.value.stringValue
                            let finalValue = String(value.unicodeScalars.filter(allowedCharset.contains))
                            print(finalValue)
                        }
                    })
                    
                }
                catch let err2 {
                    print ("failer to enurmerate",err2)
                }
            }
            else
            {
                print("Didnot grant")
            }
        }
        
    }
    /////////////////////////////////////////////////////
   
    func test()
    {
        
    }
    
    
}

