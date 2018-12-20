//
//  ViewController.swift
//  devTest
//
//  Created by Ahmed Sengab on 10/19/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

//
//  ViewController.swift
//  circularPhotoTest
//
//  Created by Ahmed Sengab on 10/7/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
import Contacts
class ViewController: UIViewController {
    
    var firstName:Array = [] as [String]
    var lastName:Array = [] as [String]
    var numberArray:Array = [] as [String]
    var statusArray:Array = [] as [Bool]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContacts()
    }
    func fetchContacts()
    {
        let allowedCharset = CharacterSet
            .decimalDigits
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, err) in
            if let error = err
            {
                print("failed to access",error)
                return
            }
            if (granted)
            {
                ///// after we get access to fetch contacts //// we reload table view data ///
                print("access granted")
                let keys = [CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactFamilyNameKey,CNContactMiddleNameKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
                        let array = contact.phoneNumbers
                        for number in array
                        {
                            let fullName = contact.givenName + contact.middleName
                            let lastName = contact.familyName
                            let value = number.value.stringValue
                            let number = String(value.unicodeScalars.filter(allowedCharset.contains))
                            print (number)
                            /////////// 4 cases we just need the phone not to be zero ///////
                            
                            if (fullName != "SPAM")
                            {
                                self.firstName.append(fullName)
                                self.lastName.append(lastName)
                                self.numberArray.append(number)
                            }
                        }
                        
                    })
                    //self.table()
                }
                catch let err2 {
                    print ("failer to enurmerate",err2)
                }
            }
        }
    }
}





