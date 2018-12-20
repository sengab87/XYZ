//
//  RosterCellExtension.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/15/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import UIKit
import Contacts
import UserNotifications
import XMPPFramework
import CoreData

extension RosterMainViewController{
    
   /* func contactRosterCell(cell: customContactsTableViewCell, newIndex: IndexPath)
    {
        let object = contactFetchedResultsController.object(at: newIndex)
        let first = object.first
        let last = object.last
        if let firstO = first, let lastO = last {
            if (!firstO.isEmpty && !lastO.isEmpty)
            {
                cell.name.text = firstO + " " + lastO
                cell.intials.text = String(firstO.first!) + String(lastO.first!)
                cell.presence.text = "Invite to chatMain"
                cell.presence.font = UIFont.systemFont(ofSize: 12)
                cell.presence.textColor = UIColor.gray

            }
            if (firstO.isEmpty && !lastO.isEmpty)
            {
                 cell.name.text = lastO
                 let final = lastO.prefix(2)
                 cell.intials.text = String(final.uppercased())
                 cell.presence.text = "Invite to chatMain"
                 cell.presence.font = UIFont.systemFont(ofSize: 12)
                 cell.presence.textColor = UIColor.gray


            }
            if (!firstO.isEmpty && lastO.isEmpty)
            {
                cell.name.text = firstO
                let final = firstO.prefix(2)
                cell.intials.text = String(final.uppercased())
                cell.presence.text = "Invite to chatMain"
                cell.presence.font = UIFont.systemFont(ofSize: 12)
                cell.presence.textColor = UIColor.gray

            }
            if (firstO.isEmpty && lastO.isEmpty){
                cell.name.text = object.number
                cell.intials.text = "UN"
                cell.presence.text = "Invite to chatMain"
                cell.presence.font = UIFont.systemFont(ofSize: 12)
                cell.presence.textColor = UIColor.gray

            }
        }
    }*/
}
