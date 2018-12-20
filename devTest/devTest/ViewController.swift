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
import AVFoundation

class ViewController: UIViewController {
    
    var firstName:Array = [] as [String]
    var lastName:Array = [] as [String]
    var numberArray:Array = [] as [String]
    var statusArray:Array = [] as [Bool]
    var contactStore = CNContactStore()
    var group = DispatchGroup()
    override func viewWillAppear(_ animated: Bool) {

        
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            print(1)
            break
        case .denied:
            print(2)
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            
        case .restricted, .notDetermined:
            self.group.enter()
            contactStore.requestAccess(for: .contacts) { granted, error in
                if granted {
                    print(3)
                    self.fetchContacts(completion: self.changeColor)
                    self.group.leave()
                } else {
                    print(4)
                    // denied
                }
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        yo()
        group.notify(queue: .main) {
            self.view.backgroundColor = UIColor.blue
        }
    }
    func changeColor()
    {
        DispatchQueue.main.async {
            self.view.backgroundColor = UIColor.blue
            print("pp")
        }
    }
    func yo()
    {
        DispatchQueue.global(qos: .userInitiated).async {
            self.group.enter()
            print("px")
            self.group.leave()
        }
    }
    func fetchContacts(completion: @escaping ()->())
    {
        
        let allowedCharset = CharacterSet
            .decimalDigits
                let keys = [CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactFamilyNameKey,CNContactMiddleNameKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        
                do {
                    try self.contactStore.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
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
                    completion()
                }
                catch let err2 {
                    print ("failer to enurmerate",err2)
                }
            }
}




