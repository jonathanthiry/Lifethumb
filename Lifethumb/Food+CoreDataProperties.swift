//
//  Food+CoreDataProperties.swift
//  Lifethumb
//
//  Created by Jonathan Thiry on 13/10/16.
//  Copyright © 2016 Jonathan Thiry. All rights reserved.
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food");
    }

    @NSManaged public var oid: Int64
    @NSManaged public var title: String?
    @NSManaged public var downloaded: Bool
    @NSManaged public var pcsingram: Double
    @NSManaged public var language: String?
    @NSManaged public var source_id: Int64
    @NSManaged public var showmeasurement: Int64
    @NSManaged public var cholesterol: Double
    @NSManaged public var gramsperserving: Double
    @NSManaged public var categoryid: Int64
    @NSManaged public var sugar: Double
    @NSManaged public var fiber: Double
    @NSManaged public var mlingram: Double
    @NSManaged public var pcstext: String?
    @NSManaged public var lastupdated: Int64
    @NSManaged public var addedbyuser: Bool
    @NSManaged public var fat: Double
    @NSManaged public var sodium: Double
    @NSManaged public var ocategoryid: Int64
    @NSManaged public var hidden: Bool
    @NSManaged public var custom: Bool
    @NSManaged public var calories: Double
    @NSManaged public var servingcategory: Int64
    @NSManaged public var saturatedfat: Double
    @NSManaged public var potassium: Double
    @NSManaged public var brand: String?
    @NSManaged public var carbohydrates: Double
    @NSManaged public var typeofmeasurement: Int64
    @NSManaged public var protein: Double
    @NSManaged public var defaultsize: Double
    @NSManaged public var showonlysametype: Int64
    @NSManaged public var unsaturatedfat: Double
    @NSManaged public var category: Category?

}
