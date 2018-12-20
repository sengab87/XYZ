//
//  RosterViewControllerExtension.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/8/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

/*import Foundation
import XMPPFramework

extension RosterViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
            let headerview: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            headerview.textLabel?.textAlignment = .center
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0)
        {
            
            print("a")
            print(fetchedResultsController.sections?[0])
            guard let sectionInfo = fetchedResultsController.sections?[0] else{
                print("b")
                return 0
            }
            print("c")
            return sectionInfo.numberOfObjects
        }
        else
        {
            print(section,"section")
            print("d")
            guard let number = UserDefaults.standard.object(forKey: "phonenumbers") as? [String] else {
                print("e")
                return 0
            }
            print("f")
            print((UserDefaults.standard.object(forKey: "phonenumbers") as? [String])!.count)
            return number.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexTest = indexPath.section
        if (indexTest == 0)
        {
            let contactCell = customContactsTableViewCell(style: .default, reuseIdentifier: contactsIdentifier)
            
            configure(cell: contactCell, for: indexPath)
            return (configure(cell: contactCell, for: indexPath))
        }
        else
        {
            let contactCell = customContactsTableViewCell(style: .default, reuseIdentifier: contactsIdentifier)
            
            return (configure(cell: contactCell, for: indexPath))
            
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0)
        {
            return "App Contacts"
        }
        else
        {
            return "Phone Contacts"
        }
    }
    func configure(cell : customContactsTableViewCell, for indexPath: IndexPath) -> customContactsTableViewCell
    {
        
        
        if (indexPath.section == 0)
        {
            
            let contact = fetchedResultsController.object(at: indexPath)
            
            
            cell.name.text = contact.jidStr
            return cell
        }
        else
        {
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
    }
    func controllerDidChangeContent(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>) {
        contactsTableView.endUpdates()
    }
    func controllerWillChangeContent(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>) {
        contactsTableView.beginUpdates()
    }
    func controller(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            contactsTableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            contactsTableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            let cell = contactsTableView.cellForRow(at: indexPath!) as! customContactsTableViewCell
            configure(cell: cell, for: indexPath!)
        case .move:
            contactsTableView.deleteRows(at: [indexPath!], with: .fade)
            contactsTableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
}*/
