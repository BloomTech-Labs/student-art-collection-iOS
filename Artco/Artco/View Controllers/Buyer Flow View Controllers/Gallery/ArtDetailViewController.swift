//
//  ArtDetailViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit
import Apollo
import Alamofire
import AlamofireImage

class ArtDetailViewController: UIViewController {
    
    // MARK: Properties & outlets
    
    @IBOutlet weak var listingImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    let ui = UIController.shared
    var id: GraphQLID?
    var listing: ArtQuery.Data.Art? 
    private let detailFetchQueue = OperationQueue()
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadListing()
    }
    
    // MARK: - Actions and functions
    
    // See FetchDetailOperation.swift for information about executing an individual query for listing information. 
    private func loadListing() {
        guard let id = id else { return }
        
        let fetchDetailOp = FetchDetailOperation(id: id)
        
        let imageConversionOp = BlockOperation {
            guard let urlString = fetchDetailOp.listing?.images?[0]?.imageUrl,
                let imageUrl = URL(string: urlString)?.usingHTTPS else { return }
            
            DispatchQueue.main.async {
                let filter = AspectScaledToFitSizeFilter(size: self.listingImageView.frame.size)
                
                self.listingImageView.af_setImage(withURL: imageUrl, filter: filter)
            }

        }
        
        let updateViewsOp = BlockOperation {
            guard let listing = fetchDetailOp.listing else { return }
            self.listing = listing
            
            DispatchQueue.main.async {
                self.ui.configureButton(self.addToCartButton)
                self.artistNameLabel.text = listing.artistName
                self.titleLabel.text = listing.title
                self.priceLabel.text = "$\(String(describing: listing.price ?? 00)).00"
                self.descriptionTextView.text = listing.description
                // Categories need to be optimized when finalized on the backend tables
                self.categoryLabel.text = "Painting"
            }
        }
        
        imageConversionOp.addDependency(fetchDetailOp)
        updateViewsOp.addDependency(imageConversionOp)
        
        detailFetchQueue.addOperation(fetchDetailOp)
        detailFetchQueue.addOperation(imageConversionOp)
        OperationQueue.main.addOperation(updateViewsOp)
        
        
    }
    
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        guard let listing = listing else { return }
        BuyerController.shared.addToCart(listing)
        dismiss(animated: true, completion: nil)
    }
    
}
