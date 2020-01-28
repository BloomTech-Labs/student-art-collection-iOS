//
//  BuyerGalleryOperation.swift
//  Artco
//
//  Created by Mitchell Budge on 1/27/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation
import Apollo

class BuyerGalleryOperation: ConcurrentOperation {
    
    let listing: AllArtQuery.Data.AllArt
    private(set) var imageData: Data?
    private let session: URLSession
    private var dataTask: URLSessionDataTask?
    
    init(listing: AllArtQuery.Data.AllArt, session: URLSession = URLSession.shared) {
        self.listing = listing
        self.session = session
        super.init()
    }
    
    override func start() {
        state = .isExecuting
        guard let imageURLString = listing.images?[0]?.imageUrl else { return }
        guard let imageURL = URL(string: imageURLString)?.usingHTTPS else { return }
        let task = session.dataTask(with: imageURL) { (data, _, error) in
            defer { self.state = .isFinished }
            if self.isCancelled { return }
            if let error = error {
                NSLog("Error fetching data for \(self.listing): \(error)")
            }
            guard let data = data else { return }
            self.imageData = data
        }
        task.resume()
        dataTask = task
    }
    
    override func cancel() {
        dataTask?.cancel()
        super.cancel()
    }
    
}
