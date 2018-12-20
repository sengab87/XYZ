//
//  Contacts+CoreDataProperties.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/10/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//
//

import Foundation
import CoreData


extension Contacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacts> {
        return NSFetchRequest<Contacts>(entityName: "Contacts")
    }

    @NSManaged public var first: String?
    @NSManaged public var number: String?
    @NSManaged public var status: Bool
    @NSManaged public var last: String?

}
