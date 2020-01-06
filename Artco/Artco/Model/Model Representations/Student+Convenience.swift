//
//  Student+Convenience.swift
//  Artco
//
//  Created by Alex Rhodes on 1/6/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation
import CoreData


extension Student {
    
    @discardableResult convenience init (studentName: String = "Anonymous",
                                         bio: String,
                                         artwork: [Listing],
                                         context: NSManagedObjectContext = NSManagedObjectContext.mainContext) {
        self.init(context: context)
        self.studentName = studentName
        self.bio = bio
        self.artwork = artwork
    }
    
}
