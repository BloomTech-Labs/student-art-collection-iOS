//
//  ListingController.swift
//  Artco
//
//  Created by Mitchell Budge on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

class ListingController {
    
    func createListing(title: String, price: Float, category: ListingCategory, artistName: String, artDescription: String, images: [String]) -> Listing {
        let listing = Listing(title: title, price: price, category: category, artistName: artistName, artDescription: artDescription, images: images)
        print(listing)
        CoreDataStack.shared.save()
        return listing
    }
    
    
    
}

/*
title: String,
sold: Bool = false,
schoolId: Float,
price: Float = 25.00,
category: ListingCategory,
artistName: String = "Anonymous",
artDescription: String = "No description provided",
images: [String],
context: NSManagedObjectContext = NSManagedObjectContext.mainContext
*/
