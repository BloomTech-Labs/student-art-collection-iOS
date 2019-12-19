//
//  Listing+Convenience.swift
//  Artco
//
//  Created by Mitchell Budge on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation
import CoreData

extension Listing {
    
    @discardableResult convenience init (title: String,
                                         sold: Bool = false,
                                         schoolId: Float,
                                         price: Float = 25.00,
                                         category: ListingCategory,
                                         artistName: String = "Anonymous",
                                         artDescription: String = "No description provided",
                                         images: [String],
                                         context: NSManagedObjectContext = NSManagedObjectContext.mainContext) {
        self.init(context: context)
        self.title = title
        self.sold = sold
        self.schoolId = schoolId
        self.price = price
        self.category = category.rawValue
        self.artistName = artistName
        self.images = images
        self.artDescription = artDescription
    }
    
}
