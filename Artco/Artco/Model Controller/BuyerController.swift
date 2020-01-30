//
//  BuyerController.swift
//  Artco
//
//  Created by Mitchell Budge on 1/9/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation
import Apollo

class BuyerController {
    
    // MARK: - Properties
    
    static let shared = BuyerController()
    
    var cart: [ArtQuery.Data.Art] = []
    
    // MARK: - Functions
    
    func addToCart(_ listing: ArtQuery.Data.Art) {
        cart.append(listing)
    }
    
}
