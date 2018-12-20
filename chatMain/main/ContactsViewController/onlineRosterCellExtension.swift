//
//  onlineRosterCellExtension.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/15/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import CoreData

extension RosterMainViewController{
    func onlineRosterCell(cell : customContactsTableViewCell, newIndex: IndexPath)
    {
        var match: [String] = []
        var userName : String
        print("online Roster")
        if let sections = self.onlineRosterFetchedResultsController.sections, newIndex.section < sections.count
        {
            if newIndex.row < sections[newIndex.section].numberOfObjects
                {
                let object = onlineRosterFetchedResultsController.object(at: newIndex)
            
                let phone = object.jidStr.replacingOccurrences(of: "@www.estore87.com", with: "")
                print(phone,"phone")
                let fetchRequest : NSFetchRequest<Contacts> = Contacts.fetchRequest()
                do {
                        let results = try coreDataStack.managedContext.fetch(fetchRequest)
                        for index in results
                        {
                            if (index.number == phone)
                            {
                                userName = index.first! + index.last!
                                cell.name.text = userName
                            }

                        }
                    }
                catch{
                    print("coulndot fetch results")
                    }
                if let profilePic = object.photo
                {
                    cell.cellView.image = profilePic
                }
                  /*  if let lastPresence = NSDate()
                {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "h:mm a"
                    
                    let elapsedTimeInSeconds = NSDate().timeIntervalSince(lastPresence as Date)
                    let secondsInDays : TimeInterval = 60 * 60 * 24
                    
                    if elapsedTimeInSeconds > 7 * secondsInDays{
                        dateFormatter.dateFormat = "dd/MM/yy"
                        
                    }
                    else if elapsedTimeInSeconds > secondsInDays {
                        dateFormatter.dateFormat = "EEE"
                        
                    }
                    cell.presence.text = dateFormatter.string(from: lastPresence as Date)
                }*/
            }
        }
    }
}
