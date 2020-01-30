//
//  Student+Convenience.swift
//  Artco
//
//  Created by Alex Rhodes on 1/6/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation
import CoreData

// This file is largely unused in RC1/2. The original plan was to allow local creation of student objects in Core Data to ensure that name misspelling wouldn't occur. In later releases it might make sense to include student objects to chose from in a drop down when making new art listings. 

extension Student {
    
    @discardableResult convenience init (studentName: String,
                                         bio: String,
                                         context: NSManagedObjectContext = NSManagedObjectContext.mainContext) {
        self.init(context: context)
        self.studentName = studentName
        self.bio = bio
    }
    
}
