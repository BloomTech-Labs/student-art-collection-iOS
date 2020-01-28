//
//  Cache.swift
//  Artco
//
//  Created by Mitchell Budge on 1/27/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation

class Cache<Key: Hashable, Value> {
    
    private var cache = [Key : Value]()
    private var queue = DispatchQueue(label: "com.lambdalabs.Artco.ConcurrentOperationStateQueue")
    
    func cache(value: Value, key: Key) {
        queue.async {
            self.cache[key] = value
        }
    }
    
    func value(key: Key) -> Value? {
        return queue.sync {
            cache[key]
        }
    }
}
