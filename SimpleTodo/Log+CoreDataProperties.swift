//
//  Log+CoreDataProperties.swift
//  SimpleTodo
//
//  Created by kenjou yutaka on 2016/09/13.
//  Copyright © 2016年 yutaka kenjo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Log {

    @NSManaged var text: String?
    @NSManaged var time: NSDate?

}
