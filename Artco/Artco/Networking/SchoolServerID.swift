//
//  SchoolServerID.swift
//  Artco
//
//  Created by Mitchell Budge on 1/13/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation
import Apollo
import FirebaseAuth

class SchoolServerID {
    
    static let shared = SchoolServerID()
    
    var firebaseId: String?
    
    var serverId: String?
    
}
