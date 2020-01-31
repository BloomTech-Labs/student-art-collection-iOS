//
//  Cloudinary.swift
//  Artco
//
//  Created by Mitchell Budge on 1/13/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation
import Cloudinary

class Cloudinary {
    
    // MARK: - Properties
    
    static let shared = Cloudinary()
    
    let cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudinaryUrl: "cloudinary://582223493288733:oAOwk2ItOL-BQUhKI5WpKuUar80@student-artco")!)
    
}
