//
//  Listing+CoreDataProperties.swift
//  
//
//  Created by Mitchell Budge on 12/19/19.
//
//

import Foundation
import CoreData


extension Listing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Listing> {
        return NSFetchRequest<Listing>(entityName: "Listing")
    }

    @NSManaged public var artDescription: String?
    @NSManaged public var artistName: String?
    @NSManaged public var category: Float
    @NSManaged public var datePosted: String?
    @NSManaged public var images: Data?
    @NSManaged public var price: Float
    @NSManaged public var schoolId: Float
    @NSManaged public var sold: Bool
    @NSManaged public var title: String?

}
