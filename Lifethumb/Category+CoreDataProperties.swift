//
//  Category+CoreDataProperties.swift
//  Lifethumb
//
//  Created by Jonathan Thiry on 14/10/16.
//  Copyright © 2016 Jonathan Thiry. All rights reserved.
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category");
    }

    @NSManaged public var category: String?
    @NSManaged public var headcategoryid: Int64
    @NSManaged public var oid: Int64
    @NSManaged public var food: Food?

}
