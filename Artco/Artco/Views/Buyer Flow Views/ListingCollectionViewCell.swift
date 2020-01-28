//
//  ListingCollectionViewCell.swift
//  Artco
//
//  Created by Mitchell Budge on 1/7/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import UIKit

class ListingCollectionViewCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        listingImageView.image = #imageLiteral(resourceName: "MarsPlaceholder")
        
        super.prepareForReuse()
    }
    
    @IBOutlet weak var listingImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
}
