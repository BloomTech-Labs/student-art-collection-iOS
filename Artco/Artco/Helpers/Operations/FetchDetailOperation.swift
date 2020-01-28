//
//  FetchDetailOperation.swift
//  Artco
//
//  Created by Mitchell Budge on 1/27/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation
import Apollo

class FetchDetailOperation: ConcurrentOperation {
    
    let id: GraphQLID
    var listing: ArtQuery.Data.Art?
    var imageData: Data?
    private let session: URLSession
    private var dataTask: URLSessionDataTask?
    
    init(id: GraphQLID, session: URLSession = URLSession.shared) {
        self.id = id
        self.session = session
        super.init()
    }
    
    override func start() {
        state = .isExecuting
        
        Network.shared.apollo
            .fetch(query: ArtQuery(id: id)) { result in
                
                defer { self.state = .isFinished }
                if self.isCancelled { return }
                
                switch result {
                case .success(let graphQLResult):
                    guard let downloadedListing = graphQLResult.data?.art else { return
                    }
                    self.listing = downloadedListing
                    
                    if let errors = graphQLResult.errors {
                        let message = errors
                            .map { $0.localizedDescription }
                            .joined(separator: "\n")
                        print("Error: \(message)")
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
        }
    }
    
    override func cancel() {
        Network.shared.apollo.fetch(query: ArtQuery(id: id)).cancel()
        super.cancel()
    }
    
}
