//
//  ListingController.swift
//  Artco
//
//  Created by Mitchell Budge on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

class ListingController {
    
    static let shared = ListingController()
    
    @discardableResult func createListing(title: String, price: Float, category: ListingCategory, artistName: String, artDescription: String, images: Data) -> Listing {
        let listing = Listing(title: title, price: price, category: category, artistName: artistName, artDescription: artDescription, images: images)
        CoreDataStack.shared.save()
        return listing
    }
    
    func deleteListing(listing: Listing) {
        CoreDataStack.shared.mainContext.delete(listing)
        CoreDataStack.shared.save()
    }
    
    
    
}
