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
    
    // MARK: Properties & Outlets
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadListing()
    }
    
    private func loadListing() {
        guard let id = id else { return }
        
        let fetchDetailOp = FetchDetailOperation(id: id)
        
        let updateViewsOp = BlockOperation {
            guard let listing = fetchDetailOp.listing else { return }
            self.listing = listing
            
            if let data = fetchDetailOp.imageData {
                DispatchQueue.main.async {
                    self.ui.configureButton(self.addToCartButton)
                    self.listingImageView.image = UIImage(data: data)
                    self.artistNameLabel.text = listing.artistName
                    self.titleLabel.text = listing.title
                    self.priceLabel.text = "$\(String(describing: listing.price!)).00"
                    self.descriptionTextView.text = listing.description
                    self.categoryLabel.text = "Painting"
                }
            }
        }
        
        updateViewsOp.addDependency(fetchDetailOp)
        
        detailFetchQueue.addOperation(fetchDetailOp)
        OperationQueue.main.addOperation(updateViewsOp)
        
        
    }
    
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        guard let listing = listing else { return }
        BuyerController.shared.addToCart(listing)
        dismiss(animated: true, completion: nil)
    }
    
}
