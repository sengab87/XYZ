//
//  NoteModel+CoreDataProperties.swift
//  Trial
//
//  Created by Ahmed Sengab on 2/5/19.
//  Copyright © 2019 Ahmed Sengab. All rights reserved.
//
//

import Foundation
import CoreData


extension NoteModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteModel> {
        return NSFetchRequest<NoteModel>(entityName: "NoteModel")
    }

    @NSManaged public var noteHiddenStatus: Bool
    @NSManaged public var noteId: Int32
    @NSManaged public var notePhoto: NSData?
    @NSManaged public var noteTxt: String?

}
