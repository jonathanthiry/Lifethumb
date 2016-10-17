//
//  Exercise+CoreDataProperties.swift
//  Lifethumb
//
//  Created by Jonathan Thiry on 12/10/16.
//  Copyright © 2016 Jonathan Thiry. All rights reserved.
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise");
    }

    @NSManaged public var title: String?
    @NSManaged public var oid: Int64
    @NSManaged public var calories: Double

}
