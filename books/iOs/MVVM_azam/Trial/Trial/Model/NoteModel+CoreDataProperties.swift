//
//  NoteModel+CoreDataProperties.swift
//  Trial
//
//  Created by Ahmed Sengab on 2/17/19.
//  Copyright © 2019 Ahmed Sengab. All rights reserved.
//
//

import Foundation
import CoreData


extension NoteModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteModel> {
        return NSFetchRequest<NoteModel>(entityName: "NoteModel")
    }

    @NSManaged public var noteClicked: Bool
    @NSManaged public var noteDate: NSDate?
    @NSManaged public var notefireDate: NSDate?
    @NSManaged public var noteHiddenStatus: Bool
    @NSManaged public var noteId: Int32
    @NSManaged public var notePhoto: NSData?
    @NSManaged public var noteRepeat: Bool
    @NSManaged public var noteTxt: String?
    @NSManaged public var noteTimeInterval: Double

}
