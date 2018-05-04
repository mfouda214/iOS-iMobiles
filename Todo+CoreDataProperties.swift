//
//  Todo+CoreDataProperties.swift
//  imobiles
//
//  Created by Mohamed Sobhi  Fouda on 5/3/18.
//  Copyright © 2018 Mohamed Sobhi Fouda. All rights reserved.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var todoListArray: NSObject?

}
