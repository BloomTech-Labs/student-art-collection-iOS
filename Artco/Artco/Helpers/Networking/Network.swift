//
//  Network.swift
//  Artco
//
//  Created by Mitchell Budge on 1/7/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation
import Apollo

class Network {
    
    // MARK: - Properties
    
    static let shared = Network()
    
    // This is the staging server endpoint. Use https://student-artco.herokuapp.com/graphql for the production endpoint.
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://student-artco-staging.herokuapp.com/graphql")!)
    
}
