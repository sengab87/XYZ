//
//  RosterViewController.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/8/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

/*import UIKit
import Contacts
import UserNotifications
import XMPPFramework

class RosterViewController: connectionStatus, UITableViewDelegate, UNUserNotificationCenterDelegate, mainProtocol,NSFetchedResultsControllerDelegate {

    let phoneNumbers = UserDefaults.standard.object(forKey: "phoneNumbers") as? [String]
    let contactsIdentifier = "contacts"
   
    lazy var fetchedResultsController : NSFetchedResultsController<XMPPResourceCoreDataStorageObject> = {
        let fetchRequest : NSFetchRequest<XMPPResourceCoreDataStorageObject> = NSFetchRequest(entityName: "XMPPResourceCoreDataStorageObject")
        let sort = NSSortDescriptor(key: #keyPath(XMPPResourceCoreDataStorageObject.jidStr), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: XMPPTest.shared.rosterStorage.mainThreadManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    var firstName:Array = [] as [String]
    var lastName:Array = [] as [String]
    var numberArray:Array = [] as [String]
    var statusArray:Array = [] as [Bool]
    var delegate : mainProtocol?
    var contactStore = CNContactStore()
    static var alert = UIAlertController()
    
    
    
    @IBOutlet weak var contactsItem: UINavigationItem!
    @IBOutlet weak var contactsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        XMPPTest.shared.regDelegate = self
        XMPPTest.shared.authDelegate = self
        XMPPTest.shared.presenceDelegate = self
        XMPPTest.shared.vcardDelegate = self
        navBarSettings()
        if (UserDefaults.standard.object(forKey: "firstRoster") != nil)
        {
                contactsAccessAuthRequest()
        }
        
        
        do {
            try fetchedResultsController.performFetch()
        }
        catch let error as NSError
        {
            print("Couldnot perfomr the fetch \(error), \(error.userInfo)")
        }
        
    }
    func navBarSettings()
    {
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    func authenticationStatus(value: Bool) {
        if (value == true)
        {
            
        }
    }
    func myPresenceStatus(value: Bool) {
        if (value == true)
        {
            contactsAccessAuthRequest()
        }
    }
    func fetchContacts(completion: () -> ())
    {
        let allowedCharset = CharacterSet
            .decimalDigits
        ///// after we get access to fetch contacts //// we reload table view data ///
        print("access granted")
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
                        
                        self.firstName.append(fullName + " ")
                        self.lastName.append(lastName)
                        self.numberArray.append(number)
                    }
                }
                
            })
            print("op")
            completion()
        }
        catch let err2 {
            print ("failer to enurmerate",err2)
        }
    }
    func tableSettings()
    {
        DispatchQueue.main.async {
            let numberCount = self.phoneNumbers?.count
            if  (numberCount == nil)
            {
                print("ss")
                UserDefaults.standard.set(self.numberArray, forKey: "phonenumbers")
                let fullName = self.combineFirstAndLastName(first: self.firstName, Second: self.lastName)
                UserDefaults.standard.set(fullName, forKey: "fullname")
                self.checkUser()
                //self.contactsTableView.reloadData()
            }
            else {
                ///// we need to remove or addCounts
                if (self.numberArray.count < numberCount!)
                {
                    UserDefaults.standard.set(self.numberArray, forKey: "phonenumbers")
                    let fullName = self.combineFirstAndLastName(first: self.firstName, Second: self.lastName)
                    UserDefaults.standard.set(fullName, forKey: "fullname")
                    self.contactsTableView.reloadData()
                }
            }
            
        }
    }
    func checkUser()
    {
        DispatchQueue.main.async {
            if let number = UserDefaults.standard.object(forKey: "phonenumbers") as? [String]
            {
                for index in (number)
                {
                    let jID = XMPPJID(string: index + "@www.estore87.com")
                    XMPPTest.shared.searchUsername(username: jID!)
                }
            }
        //RosterViewController.alert.dismiss(animated: true, completion: nil)
        }
    }
func contactsAccessAuthRequest()
{
        let result = UserDefaults.standard.object(forKey: "firstRoster")
        print(result, "test")
        if (result == nil)
        {
            print("testing Presence")
            switch CNContactStore.authorizationStatus(for: .contacts) {
            case .authorized:
                self.fetchContacts(completion: self.tableSettings)
                break
            case .denied:
                print("denied")
            case .restricted, .notDetermined:
                contactStore.requestAccess(for: .contacts) { granted, error in
                    if granted {
                        DispatchQueue.main.sync{
                        RosterViewController.alert = UIAlertController(title: nil, message: "Fetching contacts from servers", preferredStyle: .alert)
                        self.present(RosterViewController.alert,animated:true,completion:nil)
                        self.fetchContacts(completion: self.tableSettings)
                        }
                    } else {
                     //// Need to do something Here //
                    }
                }
                
            }
            ////////// Sending VCard /////////
            XMPPTest.shared.sendVcard(ProfilePic: nil)
        }
        else{
                let status = CNContactStore.authorizationStatus(for: .contacts)
                if (status == .authorized)
                {
                    do {
                        guard let numberCount = UserDefaults.standard.object(forKey: "phonenumbers") as? [String] else
                        {
                            return
                        }
                        if (self.numberArray.count > numberCount.count){
                            let extraNumbers = self.differentBetweenTwoArrays(first: self.numberArray, second: numberCount)
                            for index in extraNumbers
                            {
                                let jID = XMPPJID(string: index + "@www.estore87.com")
                                XMPPTest.shared.searchUsername(username: jID!)
                            }
                        }
                        if (self.numberArray.count == numberCount.count)
                        {
                          self.contactsTableView.reloadData()
                        }
                    }
              }
        }
}
    func combineFirstAndLastName(first: [String], Second: [String]) -> [String]{
        let finalname = zip(first,Second).map(){
            $0 + $1
        }
        return finalname
    }
    func differentBetweenTwoArrays(first: [String], second : [String]) -> [String]
    {
        let firstSet = Set(second)
        let extraNumbers = first.filter({
            m in !firstSet.contains(m)
        })
        return extraNumbers
    }
}*/
