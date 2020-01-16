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
    
    var results = [AllArtQuery.Data.AllArt]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadListings()
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
            let listing = self.results[indexPath.row]
            guard let image = listing.images?[0]?.imageUrl else {return UICollectionViewCell()}
          cell.listingImageView.image = convertToUIImage(image)
            cell.artistNameLabel.text = listing.artistName
            cell.priceLabel.text = "$\(String(describing: listing.price!)).00"
        }
        return cell
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
    
    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    private func convertToUIImage(_ str: String) -> UIImage? {
        var imageData: Data?
        guard let url = URL(string: str) else { return UIImage() }
        do {
            let data = try? Data(contentsOf: url)
            imageData = data
        } catch {
            fatalError("URL was not compatible.")
        }
        
        return UIImage(data: imageData ?? Data())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowListingDetail" {
            let destination = segue.destination as? ArtDetailViewController
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            destination?.id = self.results[indexPath.row].id
        }
    }
    
}

