//
//  ListingCollectionViewCell.swift
//  Artco
//
//  Created by Mitchell Budge on 1/7/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import UIKit

class ListingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var listingImageView: UIImageView!
    // While attempting to add custom collection view layouts that size dynamically, it made more sense for cells to not include name or price labels. These are here to use if a better layout is found. 
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
}
