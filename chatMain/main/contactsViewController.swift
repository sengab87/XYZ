//
//  contactsViewController.swift
//  chatMain
//
//  Created by Ahmed Sengab on 8/13/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
import Contacts
import UserNotifications
import XMPPFramework


class contactsViewController: connectionStatus, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate, mainProtocol,NSFetchedResultsControllerDelegate {
    var prensenceStatus : Bool?
    var fetchingStauts: Bool?
    var firstName:Array = [] as [String]
    var lastName:Array = [] as [String]
    var numberArray:Array = [] as [String]
    var statusArray:Array = [] as [Bool]
    var delegate : mainProtocol?
    var usernameDelegate: mainProtocol?
    var contactStore = CNContactStore()
    static var alert = UIAlertController()
    var group = DispatchGroup()
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var contactsItem: UINavigationItem!
    
    
 
    //////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hj")
        XMPPTest.shared.regDelegate = self
        XMPPTest.shared.authDelegate = self
        XMPPTest.shared.presenceDelegate = self
        XMPPTest.shared.vcardDelegate = self
        
        navBarSettings()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       /* guard let number = UserDefaults.standard.object(forKey: "phonenumbers") as? [String]
            else {
                return 0
        }
        return number.count*/
        return 0
        
        
      
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = customContactsTableViewCell(style: .default, reuseIdentifier: "contacts")
    
            //let jID = XMPPJID(string: String(self.numberArray[indexPath.row]) + "@www.estore87.com")
            //let statusFinal = XMPPTest.shared.searchUsernameOffline(username: jID!)
             //let statusFinal:(Bool,UIImage?) = (true,nil)
            if (self.firstName[indexPath.row].isEmpty && self.lastName[indexPath.row].isEmpty)
            {
                
                
                    cell.intials.text = "UN" //+ String(chartwo!)

                
                cell.name.text = self.numberArray[indexPath.row]
                cell.presence.text = " "
                
            }
            if (!self.firstName[indexPath.row].isEmpty || !self.lastName[indexPath.row].isEmpty )
            {
            
                if (self.firstName[indexPath.row].isEmpty)
                {
                   
                        let charone = String(self.lastName[indexPath.row])
                        let final  = charone.prefix(2)
                        cell.intials.text = String(final.uppercased()) //+ String(chartwo!)
                    cell.name.text =  self.lastName[indexPath.row]
                    cell.presence.text = self.numberArray[indexPath.row]
                    
                   
                }
                if (self.lastName[indexPath.row].isEmpty)
                {
                   
                        let charone = String(self.firstName[indexPath.row])
                        let final  = charone.prefix(2)
                        cell.intials.text = String(final.uppercased()) //
                    cell.name.text = self.firstName[indexPath.row]
                    cell.presence.text = self.numberArray[indexPath.row]
                   
                }
                if (!self.lastName[indexPath.row].isEmpty && !self.firstName[indexPath.row].isEmpty)
                {
                    
                        let charone = String((self.firstName[indexPath.row].first!)) + String(self.lastName[indexPath.row].first!)
                        cell.intials.text = charone.uppercased()
                    
                    cell.name.text = self.firstName[indexPath.row] + " " + self.lastName[indexPath.row]
                    cell.presence.text = self.numberArray[indexPath.row]
                  
                }
               
        }
      return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableView.numberOfSections)
        let cond = statusArray[indexPath.row]
        if (cond)
        {
            let cell = tableView.cellForRow(at: indexPath) as! customContactsTableViewCell
            self.usernameDelegate = messageViewController()
            self.performSegue(withIdentifier: "statusTrue", sender: self)
            usernameDelegate?.userName!(intials: cell.intials.text!, name: cell.name.text!)
        }
        else{self.performSegue(withIdentifier: "statusFalse", sender: self)}
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////

   
   
    ////////////// navBar settings //////////////////
    func navBarSettings()
    {
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    /////////////////////////////////////////////////////
    ///////////////// fetching Contacts /////////////////
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
                                //print (number)
                                /////////// 4 cases we just need the phone not to be zero ///////
                
                                if (fullName != "SPAM")
                                {
                                    
                                    self.firstName.append(fullName)
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

    
    
    /////// Here we reload table data and add header Views ///
    func tableSettings ()
    {
       
            saveList()
    }
    /////// Status ////////////////////////////////////////
    func saveList()
    {
        print("group2)")
        if (UserDefaults.standard.object(forKey: "phonenumbers") == nil)
        {
            print("ss")
            UserDefaults.standard.set(self.firstName, forKey: "firstName")
            UserDefaults.standard.set(self.lastName, forKey: "lastName")
            UserDefaults.standard.set(self.numberArray, forKey: "phonenumbers")
            XMPPTest.shared.sendVcard(ProfilePic: nil)

        }
        self.checkUser(completion: updateTable)
        
    }
    func authenticationStatus(value: Bool) {
        if (value == true)
        {
            
        }
    }
    func myPresenceStatus(value: Bool) {
        if(value == true)
        {
           print("printPresence")
            switch CNContactStore.authorizationStatus(for: .contacts) {
                
            case .authorized:
                print("cont auth")
                
                print("group1")
                self.fetchContacts(completion: self.tableSettings)
                
                break
            case .denied:
                print(2)
            case .restricted, .notDetermined:
                
                contactStore.requestAccess(for: .contacts) { granted, error in
                    if granted {
                        print(3)
                        self.fetchContacts(completion: self.tableSettings)
                        
                    } else {
                        print(4)
                        // denied
                    }
                }
                
            }
            
        }
    }
    func newContactIsAdded(firstName: String?, LastName: String?, phoneOne: String?, phoneTwo: String?, phoneThree: String?) {
        addNewContact(firstName: firstName, LastName: LastName, phoneOne: phoneOne, phoneTwo: phoneTwo, phoneThree: phoneThree)
        
    }
    func addNewContact(firstName: String?, LastName: String?, phoneOne: String?, phoneTwo: String?, phoneThree: String?)
    {
        let contact = CNMutableContact()
      
       
                contact.givenName = firstName!
                contact.familyName = LastName!
        
    
        if ((phoneOne?.isEmpty)! && (phoneTwo?.isEmpty)! && !(phoneThree?.isEmpty)!)
        {
            print("3a")
            ///3///
            contact.phoneNumbers = [ CNLabeledValue(label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: phoneThree!))]
        }
        if ((phoneOne?.isEmpty)! && (phoneThree?.isEmpty)! && !(phoneTwo?.isEmpty)!)
        {
            print("2a")
            //// 2 ///
            contact.phoneNumbers = [ CNLabeledValue(label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: phoneTwo!))]
        }
        if ((phoneTwo?.isEmpty)! && (phoneThree?.isEmpty)!) && !(phoneOne?.isEmpty)!
        {
            print("1a")
            //// 1 ///
            contact.phoneNumbers = [ CNLabeledValue(label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: phoneOne!))]
        }
        if((phoneOne?.isEmpty)! && !((phoneTwo?.isEmpty)!) && !(phoneThree?.isEmpty)!)
        {
            print("2a,3a")
            ///2&3///
           contact.phoneNumbers = [ CNLabeledValue(label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: phoneTwo!)),CNLabeledValue(label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: phoneThree!))]
        }
        if ((phoneTwo?.isEmpty)! && !((phoneOne?.isEmpty)!) && !(phoneThree?.isEmpty)!)
        {
            print("1a,3a")
            ////1&3///
             contact.phoneNumbers = [ CNLabeledValue(label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: phoneOne!)),CNLabeledValue(label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: phoneThree!))]
        }
        if((phoneThree?.isEmpty)! && !((phoneOne?.isEmpty)!) && !(phoneTwo?.isEmpty)!)
        {
            print("1a,2a")
            //// 1 & 2////
            contact.phoneNumbers = [ CNLabeledValue(label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: phoneOne!)),CNLabeledValue(label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: phoneTwo!))]
        }
        if (!(phoneOne?.isEmpty)! && !(phoneTwo?.isEmpty)! && !(phoneThree?.isEmpty)!)
        {
            contact.phoneNumbers = [ CNLabeledValue(label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: phoneOne!)),CNLabeledValue(label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: phoneTwo!)),CNLabeledValue(label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: phoneThree!))]
        }

        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)
        do {try store.execute(saveRequest)
        }
        catch{
            print(error)
        }
    }
   
    func checkUser(completion :@escaping ()->())
    {
        
        DispatchQueue.global(qos: .userInteractive).async {
            let number = UserDefaults.standard.object(forKey: "phonenumbers") as? [String]
            for index in number!
            {
                let jID = XMPPJID(string: index + "@www.estore87.com")
                XMPPTest.shared.searchUsername(username: jID!)
            }
           completion()
        }
        
    }

    func updateTable()
    {
        DispatchQueue.main.async {
            self.contactsTableView.reloadData()
            print("test1")
        }
    }
}
