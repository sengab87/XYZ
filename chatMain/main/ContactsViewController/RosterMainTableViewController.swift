//
//  RosterMainTableViewController.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/11/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

//////////// NEED TO CONFIGURE CELL ////////

import Foundation
import UIKit
import Contacts
import UserNotifications
import XMPPFramework
import CoreData

extension RosterMainViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = onlineRosterFetchedResultsController.fetchedObjects else{
            return 0
        }
        print(sectionInfo.count,"test")
        return sectionInfo.count
        
        /*let finalSegment = returnSegmentedControlIndex()
        switch finalSegment {
        case 0:*/
        //determineChangeInContactStore()
        //print("determine")
          //  return rowsInSection
       /* case 1:
            return rowsInSection.1
        default:
            return 0
        }*/
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        /*switch section {
        case 0:
            return "CONTACTS"
        default:
            return nil
        }*/
        return "CONTACTS"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        print("sections")
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = customContactsTableViewCell(style: .default, reuseIdentifier: contactsIdentifier)
        /*print(indexPath.section)
        let finalSegment = returnSegmentedControlIndex()*/
        /*switch finalSegment {
        case 0:*/
            configureCell(inputcell: cell, index: indexPath, status: true)
        /*case 1:
            configureCell(inputcell: cell, index: indexPath, status: false)
        default:
            print("default")
        }*/
        return cell
    }
   
    func tableViewRowsCount() -> (Int)
    {
        
        let contactsResults = fetchingTables()
        /*print(contactsResults)
        let totalCount = Array(contactsResults.0 + contactsResults.1).count
        let rosterCount = contactsResults.0.count
        let contactsCount = totalCount - rosterCount
        print("in tableView rows count ", rosterCount,contactsCount)*/
        return (contactsResults.count)
        
    }
    func fetchingTables() -> ([String])
    {
        var onlineRosterNumbers: [String] = []
        if let onlineRoster = onlineRosterFetchedResultsController.fetchedObjects
        {
            onlineRosterNumbers = onlineRoster.map {$0.jidStr}
            print(onlineRosterNumbers,"online numbers")
        }
        /*var contactsNumbers: [String] = []
        if let contacts = contactFetchedResultsController.fetchedObjects
        {
            contactsNumbers = contacts.map {$0.number!}
            print(contactsNumbers, "contacts number")
        }*/
        return (onlineRosterNumbers)
    }
    func configureCell(inputcell : customContactsTableViewCell, index: IndexPath, status: Bool)
    {
        if(status)
        {
            onlineRosterCell(cell: inputcell, newIndex: index)
        }
        
        else
        {
           // contactRosterCell(cell: inputcell, newIndex: index)
        }
        
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("yoyo")
        print(controller.debugDescription, "controller")
        print(object_getClassName(controller), "controllers")
        switch type {
        case .insert:
            
            print("insert")
            print(object_getClassName(controller), "controllers")
            print(newIndexPath!.section, "indexpath")
           
            
           // if (!rosterTableView.isHidden && contactTableView.isHidden)
            //{
                self.rosterTableView.insertRows(at: [newIndexPath!], with: .fade)
                
            //}
           /* if (rosterTableView.isHidden && !contactTableView.isHidden){
            self.contactTableView.insertRows(at: [newIndexPath!], with: .fade)
            
            }*/
            
        case .delete:
        
            //if (!rosterTableView.isHidden && contactTableView.isHidden)
            //{
               self.rosterTableView.deleteRows(at: [indexPath!], with: .fade)
            //}
            /*if (rosterTableView.isHidden && !contactTableView.isHidden){
            
               self.contactTableView.deleteRows(at: [indexPath!], with: .fade)
            }*/
                

        case .update:
            //if (!rosterTableView.isHidden && contactTableView.isHidden)
            //{
           
                    let cell = customContactsTableViewCell(style: .default, reuseIdentifier: contactsIdentifier)
                    configureCell(inputcell: cell, index: indexPath!, status: true)
            //}
            /*if (rosterTableView.isHidden && !contactTableView.isHidden)
            {
                    print("in 1")
                    let cell = customContactsTableViewCell(style: .default, reuseIdentifier: contactsIdentifier)
                    configureCell(inputcell: cell, index: indexPath!, status: false)
            }*/
        case .move:
            //if (!rosterTableView.isHidden && contactTableView.isHidden)
            //{
              //      print("in 0")
                    self.rosterTableView.deleteRows(at: [indexPath!], with: .fade)
                    self.rosterTableView.insertRows(at: [newIndexPath!], with: .fade)
            //}
           /* if (rosterTableView.isHidden && !contactTableView.isHidden)
            {
                    print("in 1")
                    self.contactTableView.deleteRows(at: [indexPath!], with: .fade)
                    self.contactTableView.insertRows(at: [newIndexPath!], with: .fade)
            }*/
        }
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //if (!rosterTableView.isHidden && contactTableView.isHidden)
        //{
            print("updating 0")

            self.rosterTableView.beginUpdates()
        //}
        
        //if (!rosterTableView.isHidden && !contactTableView.isHidden)
        //{
            print("updating 1")
            //self.contactTableView.beginUpdates()
        
        //}
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //if (!rosterTableView.isHidden && contactTableView.isHidden)
        //{
            self.rosterTableView.beginUpdates()
            let object = onlineRosterFetchedResultsController.fetchedObjects
        for t in object! {
            
            print(t.jidStr)
           // print(t.primaryResource.presenceStr)
           
                
        }
        //self.rosterTableView.reloadData()
        print("updated")
        //}
        /*if (rosterTableView.isHidden && !contactTableView.isHidden)
        {
            print("updated 1")
            self.contactTableView.beginUpdates()
      
        }*/
    }
    func returnSegmentedControlIndex() -> Int
    {
        return contactsSegmented.selectedSegmentIndex
    }
    
}
