//
//  Float+CurrencyFormatter.swift
//  Artco
//
//  Created by Mitchell Budge on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

extension Float {
    
    func currencyOutputFormatting() -> String {
        
        let number: NSNumber!
        
        let amountWithPrefix = self
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        let double = amountWithPrefix
        number = NSNumber(value: (double))
        
        guard number != 0 as NSNumber else {
            return "$0.00"
        }
        
        return formatter.string(from: number)!
    }
    
}
