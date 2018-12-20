//
//  RosterMainViewController.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/10/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
import Contacts
import UserNotifications
import XMPPFramework
import CoreData

class RosterMainViewController: connectionStatus, UITableViewDelegate, UNUserNotificationCenterDelegate, mainProtocol,NSFetchedResultsControllerDelegate {

    let contactsIdentifier = "contacts"
    var coreDataStack = CoreDataStack(modelName: "contactsStore")
    var mainNumber : Int!
    var firstName:Array = [] as [String]
    var lastName:Array = [] as [String]
    var numberArray:Array = [] as [String]
    var statusArray:Array = [] as [Bool]
    var differenceArray:Array = [] as [String]
    var delegate : mainProtocol?
    var contactStore = CNContactStore()
    static var alert = UIAlertController()
    var presenceStatus : Bool?
    var firstTime: Bool?
    var coreDataSave : Bool? {
        didSet{
            guard let final = coreDataSave, let final1 = presenceStatus else
            {
                return
            }
            if (final && final1)
            {
                print("did")
                searchUsers()
            }
        }
    }
    
    @IBOutlet weak var contactsSegmented: UISegmentedControl!
    @IBOutlet weak var contactsItem: UINavigationItem!
    @IBOutlet weak var rosterTableView: UITableView!
    

    /////////// FetchedResultsController ////////////
    lazy var onlineRosterFetchedResultsController : NSFetchedResultsController<XMPPUserCoreDataStorageObject> = {
        let fetchRequest : NSFetchRequest<XMPPUserCoreDataStorageObject> = NSFetchRequest(entityName: "XMPPUserCoreDataStorageObject")
        let sortDescriptor = NSSortDescriptor(key: #keyPath(XMPPUserCoreDataStorageObject.jidStr), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: XMPPTest.shared.rosterStorage.mainThreadManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self
        return fetchResultsController
    }()
    
    ////////// Contact Store ///////////////////
    /*lazy var contactFetchedResultsController : NSFetchedResultsController<Contacts> = {
        let fetchRequest : NSFetchRequest<Contacts> = Contacts.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Contacts.status), ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self
        return fetchResultsController
    }()*/
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(coreDataStack, "stack")
        XMPPTest.shared.regDelegate = self
        XMPPTest.shared.authDelegate = self
        XMPPTest.shared.presenceDelegate = self
        XMPPTest.shared.vcardDelegate = self
        navBarSettings()
        contactAccessAuthorization()
        controllersFetching()
        self.rosterTableView.tableFooterView = UIView()
        
    }
    
   
    func navBarSettings(){
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
            self.presenceStatus = true
            XMPPTest.shared.sendVcard(ProfilePic: nil)
            //XMPPTest.shared.lastactivity.sendQuery(to: XMPPJID(string: "15184285071@www.estore87.com"))
        }
    }
    func contactAccessAuthorization()
    {
        DispatchQueue.main.async {
            switch CNContactStore.authorizationStatus(for: .contacts) {
            case .authorized:
                self.fetchContacts(completion: self.determineChangeInContactStore)
                print(1)
                break
            case .denied:
                print("denied")
            case .restricted, .notDetermined:
                self.contactStore.requestAccess(for: .contacts) { granted, error in
                    if granted {
                        DispatchQueue.main.async{
                            print("ingranted")
                            self.fetchContacts(completion: self.tableSettings)
                        }
                    } else {
                        //// Need to do something Here //
                    }
                }
                
            }
        }
    }
    func searchUsers()
    {
        print(firstTime,"firstTime")
        var number = [] as! [String]
        if (self.firstTime == nil)
        {
            number = contactsInPhone()
            print(number, "numbers")
        }
        else {
            number = self.differenceArray
        }
            for index in number
            {
                guard let jid = XMPPJID(string: index + "@" + XMPPTest.shared.host) else {
                    return
                }
                print("searching",index)
                XMPPTest.shared.searchUsername(username: jid)
            }
    }
    func controllersFetching()
    {
       
        print("fetching")
        do {
            try onlineRosterFetchedResultsController.performFetch()
        }
        catch let err{
            print("couldnot fetch online roster \(err)")
        }
        /*do {
            try contactFetchedResultsController.performFetch()
        }
        catch let err{
             print("couldnot fetch contacts \(err)")
        }*/
    }
    func contactsInPhone() -> [String]
    {
        var numbers: [String] = []
        let fetchRequest : NSFetchRequest<Contacts> = Contacts.fetchRequest()
        do {
            let results = try coreDataStack.managedContext.fetch(fetchRequest)
            for index in results
            {
                numbers.append(index.number!)
            }
        }
        catch{
            print("couldnot fetch")
        }
        return numbers
    }
    func determineChangeInContactStore()
    {
        let numbers = contactsInPhone()
        if (numbers.count > numberArray.count){
            
            let phone = Set(numbers)
            let final = numberArray.filter { m in !phone.contains(m) }
            self.firstTime = true
            self.differenceArray = final
            self.coreDataSave = true
        }
        if (numbers.count < numberArray.count){
            
            let phone = Set(numbers)
            let final = numberArray.filter { m in !phone.contains(m) }
            removeEntityFromCoreData(removed: final)
        }
        if (numbers.count == numberArray.count){
            let objects = onlineRosterFetchedResultsController.fetchedObjects
            print(objects?.count,"obj")
        }
    }
    func removeEntityFromCoreData(removed: [String])
    {
        
            let fetchRequest : NSFetchRequest<Contacts> = Contacts.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: #keyPath(Contacts.number), ascending: true)
            let predicate = NSPredicate(format: "number IN %@", removed)
            fetchRequest.sortDescriptors = [sortDescriptor]
            fetchRequest.predicate = predicate
        do {
                let final = try coreDataStack.managedContext.fetch(fetchRequest)
                
                for t in final
                {
                    coreDataStack.managedContext.delete(t)
                }
                do {
                    try coreDataStack.managedContext.save()
                }
                catch let err {
                    print("could save deleted objectect \(err)")
                }
        }
        catch let err {
            print("couldnot fetch removed objects \(err)")
        }
       
    }
    @IBAction func contactsChanged(_ sender: UISegmentedControl) {
        /*let segment = returnSegmentedControlIndex()
        switch segment
        {
            case 0:
                self.rosterTableView.isHidden = false
                //self.contactTableView.isHidden = true
                //self.rosterTableView.reloadData()
            print("segmented is 0")
            case 1:
                self.rosterTableView.isHidden = true
                self.contactTableView.isHidden = false
                self.contactTableView.reloadData()

            print("segmented is 1")
            default:
            print("nil")
        }*/
    }
    
}
