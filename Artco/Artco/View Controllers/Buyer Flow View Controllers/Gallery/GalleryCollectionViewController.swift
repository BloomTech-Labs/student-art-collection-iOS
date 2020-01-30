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
    
}

class GalleryCollectionViewController: UICollectionViewController {
    
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
    private var token: String? {
        didSet {
            DispatchQueue.main.async {
                self.filter()
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObservers()
        loadListings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createObservers()
    }
    
    // MARK: UICollectionViewDataSource
    
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
    
    private func createObservers() {
        NotificationCenter.default.addObserver(forName: Notification.Name(String.filterNotificationKey), object: nil, queue: OperationQueue.main) { (notification) in
            guard let userInfo = notification.userInfo else {return}
            self.token = "\(String(describing: userInfo["name"]))"
        }
    }
    
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
                case .failure:
                    print("You suck this didn't work you dumb bitch")
                }
        }
    }
    
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
                print("Got image for reused cell")
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
    
    private func filter() {
        self.results = results.filter{ $0.school?.zipcode == "54321" && $0.category?.category == "Photography" }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowListingDetail" {
            let destination = segue.destination as? ArtDetailViewController
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            destination?.id = self.results[indexPath.row].id
        }
    }
    
}

