//
//  ListingController.swift
//  Artco
//
//  Created by Mitchell Budge on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class ListingController {
    
    // MARK: Properties
    
    static let shared = ListingController()
    
    var artBySchool: [ArtBySchoolQuery.Data.ArtBySchool] = []
    
    // MARK: Functions 
    
    func syncCoreData() {
        
        guard let id = UserDefaults.standard.string(forKey: "schoolID") else { return }
        
        Network.shared.apollo
            .fetch(query: ArtBySchoolQuery(school_id: id)) { [weak self] result in
                
                guard let self = self else {return}
                let context = CoreDataStack.shared.backgroundContext
                
                do {
                    let fetchRequest: NSFetchRequest<Listing> = Listing.fetchRequest()
                    let existingListings = try context.fetch(fetchRequest)
                    switch result {
                    case .success(let graphQLResult):
                        if let listings = graphQLResult.data?.artBySchool {
                            if listings.count != existingListings.count {
                                self.artBySchool.append(contentsOf: listings)
                                self.performCoreDataFetch()
                                print(listings.count)
                            }
                        }
                        
                        if let errors = graphQLResult.errors {
                            let message = errors
                                .map { $0.localizedDescription }
                                .joined(separator: "\n")
                            NSLog("\(message)")
                        }
                    case .failure:
                        print("You suck this didn't work you dumb bitch")
                    }
                } catch {
                    NSLog("Error fetching coredata objects: \(error)")
                }
        }
        
    }
    
    private func performCoreDataFetch() {
        
        let identifiersToFetch = self.artBySchool.compactMap({ $0.id })
        
        let listingsByID = Dictionary(uniqueKeysWithValues: zip(self.artBySchool.compactMap({ $0.id }), self.artBySchool))
        
        var listingsToCreate = listingsByID
        
        let context = CoreDataStack.shared.backgroundContext
        
        
        context.performAndWait {
            
            do {
                let fetchRequest: NSFetchRequest<Listing> = Listing.fetchRequest()
    
               fetchRequest.predicate = NSPredicate(format: "id IN %@", identifiersToFetch)
                
                let existingListings = try context.fetch(fetchRequest)
                
                _ = existingListings.map {
                    let identifier = String($0.id)
                    guard let listing = listingsByID[identifier] else { return }
                    
                    $0.artDescription = listing.description
                    
                    $0.artistName = listing.artistName
                    $0.datePosted = listing.datePosted
                    $0.id = Float(listing.id)!
                    let image = #imageLiteral(resourceName: "artboard")
                    
                    $0.images = image.pngData()
                    $0.price = Float(listing.price!)
                    $0.schoolId = Float(listing.schoolId)!
                    
                    listingsToCreate.removeValue(forKey: identifier)
                    
                }
                
                _ = listingsToCreate.values.map { (art) in
                    guard let title = art.title,
                        let price = art.price,
                        let artistName = art.artistName,
                        let descriptioin = art.description,
                        let _ = art.images else {return}
                    
                    let image = #imageLiteral(resourceName: "artboard")
                    guard let imageData = image.pngData() else { return }
                    
                    
                    
                    self.createListing(title: title, price: Float(price), category: "1", artistName: artistName, artDescription: descriptioin, images: imageData)
                }
                
            } catch {
                NSLog("Error syncing coredata and networking: \(error)")
            }
        
        }
    }
    
    
    @discardableResult func createListing(title: String, price: Float, category: String, artistName: String, artDescription: String, images: Data) -> Listing {
        let listing = Listing(title: title, price: price, category: category, artistName: artistName, artDescription: artDescription, images: images)
        CoreDataStack.shared.save()
        return listing
    }
    
    @discardableResult func updateListing(id: Float, listing: Listing, title: String, price: Float, category: String, artistName: String, artDescription: String, images: Data) -> Listing {
        listing.id = id
        listing.title = title
        listing.price = price
        listing.category = category
        listing.artistName = artistName
        listing.artDescription = artDescription
        listing.images = images
        CoreDataStack.shared.save()
        return listing
    }
    
    func deleteListing(listing: Listing) {
        CoreDataStack.shared.mainContext.delete(listing)
        CoreDataStack.shared.save()
    }
    
    
}


