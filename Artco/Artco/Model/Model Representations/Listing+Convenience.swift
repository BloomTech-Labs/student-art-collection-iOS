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
                                         schoolId: Float = 1,
                                         price: Float,
                                         category: ListingCategory,
                                         artistName: String,
                                         artDescription: String,
                                         images: Data,
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
