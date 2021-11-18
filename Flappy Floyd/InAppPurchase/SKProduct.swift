//
//  SKProduct.swift
//  Flappy Floyd
//
//  Created by Dustin Moore on 10/27/19.
//  Copyright © 2019 Dustin Moore. All rights reserved.
//

import StoreKit

public extension SKProduct {
    
    convenience init(identifier: String) {
        
        self.init()
        self.setValue(identifier, forKey: "productIdentifier")
        
    }
    
}
