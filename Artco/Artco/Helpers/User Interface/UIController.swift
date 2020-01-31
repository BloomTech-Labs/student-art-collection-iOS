//
//  UIController.swift
//  Artco
//
//  Created by Alex Rhodes on 1/14/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation
import UIKit

class UIController {
    
    static let shared = UIController()
    
    func configureButton(_ button: UIButton) {
        button.layer.cornerRadius = 2
    }
}
