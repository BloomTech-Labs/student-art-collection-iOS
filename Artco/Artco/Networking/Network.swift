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
  static let shared = Network()
    
  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://student-artco.herokuapp.com/graphql")!)
}
