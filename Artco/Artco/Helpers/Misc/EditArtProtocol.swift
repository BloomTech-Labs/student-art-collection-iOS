
//
//  EditArtProtocol.swift
//  Artco
//
//  Created by Alex Rhodes on 12/20/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

protocol EditArtDelegate {

    func artUpdated(_ listing: Listing) -> Listing
}
