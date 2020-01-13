//
//  School+Convenience.swift
//  Artco
//
//  Created by Mitchell Budge on 1/13/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation
import CoreData

extension School {
    
    @discardableResult convenience init (schoolId: String,
                                         schoolName: String,
                                         email: String,
                                         address: String,
                                         city: String,
                                         zipcode: String,
                                         context: NSManagedObjectContext = NSManagedObjectContext.mainContext) {
        self.init(context: context)
        self.schoolId = schoolId
        self.schoolName = schoolName
        self.email = email
        self.address = address
        self.city = city
        self.zipcode = zipcode
    }
}
