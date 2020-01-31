//
//  GalleryCollectionViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

enum ListSection: Int, CaseIterable {
    case allArts
    // different cases can allow for different displays depending on what query to fetch listings is executed.
}

class GalleryCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let cache = Cache<Int, Data>()
    private let galleryFetchQueue = OperationQueue()
    private var operations = [Int : Operation]()
    private var results = [AllArtQuery.Data.AllArt]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObservers()
        loadListings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createObservers()
    }
    
    // MARK: - Collection view data source methods
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ListSection.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let listSection = ListSection(rawValue: section) else {
            assertionFailure("Invalid section")
            return 0
        }
        
        switch listSection {
        case .allArts:
            return self.results.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListingCell", for: indexPath) as? ListingCollectionViewCell else { return UICollectionViewCell() }
        
        guard let listSection = ListSection(rawValue: indexPath.section) else {
            assertionFailure("Invalid section")
            return cell
        }
        
        switch listSection {
        case .allArts:
            loadInfo(forCell: cell, forItemAt: indexPath)
        }
        return cell
    }
    
    // MARK: - Functions
    
    // This partially unfinished methods will look for changes in FilterViewController.swift's text fields to narrow search and filter results
    private func createObservers() {
        NotificationCenter.default.addObserver(forName: Notification.Name(String.filterNotificationKey), object: nil, queue: OperationQueue.main) { (notification) in
            guard notification.userInfo != nil else {return}
            // Execute filtering here locally if the backend queries are not functional (which was the case at the time of the RC2 demonstation
        }
    }
    
    // This method will fetch all possible listings on the server.
    private func loadListings() {
        guard isViewLoaded else { return }
        Network.shared.apollo
            .fetch(query: AllArtQuery()) { [weak self] result in
                
                guard let self = self else {
                    return
                }
                
                defer {
                    self.collectionView.reloadData()
                }
                
                switch result {
                case .success(let graphQLResult):
                    if let listings = graphQLResult.data?.allArts {
                        self.results.append(contentsOf: listings.compactMap { $0 })
                    }
                    
                    if let errors = graphQLResult.errors {
                        let message = errors
                            .map { $0.localizedDescription }
                            .joined(separator: "\n")
                        self.showErrorAlert(title: "GraphQL Error(s)",
                                            message: message)
                    }
                case .failure(let error):
                        print("Unable to fetch results from server: \(error)")
                }
        }
    }
    
    // This concurrent method moves image conversion and caching to background thread for optimized performance. This method could certainly be more optimized.
    private func loadInfo(forCell cell: ListingCollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let listing = results[indexPath.item]
        guard let listingId = Int(listing.id) else { return }
        
        if let cachedData = cache.value(key: listingId),
            let image = UIImage(data: cachedData) {
            cell.listingImageView.image = image
            return
        }
        
        let buyerFetchOp = BuyerGalleryOperation(listing: listing)
        
        let cacheOp = BlockOperation {
            if let data = buyerFetchOp.imageData {
                self.cache.cache(value: data, key: listingId)
            }
        }
        
        let completionOp = BlockOperation {
            defer { self.operations.removeValue(forKey: listingId) }
            if let currentIndexPath = self.collectionView.indexPath(for: cell),
                currentIndexPath != indexPath {
                return
            }
            if let data = buyerFetchOp.imageData {
                cell.listingImageView.image = UIImage(data: data) ?? UIImage(named: "Nike")
            }
        }
        
        cacheOp.addDependency(buyerFetchOp)
        completionOp.addDependency(buyerFetchOp)
        
        galleryFetchQueue.addOperation(buyerFetchOp)
        galleryFetchQueue.addOperation(cacheOp)
        OperationQueue.main.addOperation(completionOp)
        
        operations[listingId] = buyerFetchOp
        
    }
    
    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    private func convertToUIImage(_ str: String) -> UIImage? {
        var imageData: Data?
        guard let url = URL(string: str)?.usingHTTPS else { return UIImage() }
        do {
            let data = try? Data(contentsOf: url)
            imageData = data
        }
        return UIImage(data: imageData ?? Data())
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowListingDetail" {
            let destination = segue.destination as? ArtDetailViewController
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            // Pass the listings id so that it can be queried (it might be more optimal to just pass the entire object) 
            destination?.id = self.results[indexPath.row].id
        }
    }
    
}

