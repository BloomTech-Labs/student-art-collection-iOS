//
//  SEditArtViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/20/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class SEditArtViewController: UIViewController {
    
    @IBOutlet weak var artistNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    var listing: Listing? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let listing = listing,
            let title = listing.title,
            let category = ListingCategory(rawValue: 1),
            let artDescription = listing.artDescription,
            let images = listing.images,
            let artistName = artistNameTextField.text,
            !artistName.isEmpty else { return }
        
        ListingController.shared.updateListing(listing: listing, title: title, price: listing.price, category: category, artistName: artistName, artDescription: artDescription, images: images)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    private func updateViews() {
        guard let listing = listing, isViewLoaded else { return }
        
        artistNameTextField.text = listing.artistName
    }
    
    
}

