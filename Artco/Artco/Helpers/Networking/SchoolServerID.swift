//
//  SchoolServerID.swift
//  Artco
//
//  Created by Mitchell Budge on 1/13/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation

class SchoolServerID {
    
    // MARK: - Properties
    
    static let shared = SchoolServerID()
    // School id based upon Firebase authenticated sign in
    var firebaseId: String?
    // Server id based upon unique GraphQL school identification 
    var serverId: String? 
    
}
