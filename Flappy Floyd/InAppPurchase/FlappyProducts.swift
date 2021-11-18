//
//  FlappyProducts.swift
//  Flappy Floyd
//
//  Created by Dustin Moore on 10/27/19.
//  Copyright © 2019 Dustin Moore. All rights reserved.
//

import Foundation

public struct FlappyProducts {
    
    // NON CONSUMABLE REMOVE ADS & UNLOCK ALL SKINS +1000 GEMS
    public static let PremiumFlappy = "PREMIUMFLOYD2019"
    
    // NON CONSUMABLE AKA REMOVE ADS
    public static let NoAdsFlappy = "NOADSFLAPPY2019"
    
    // CONSUMABLES AKA GEMS
    public static let thousandGems = "1000GEMS"
    public static let twentyFiveHundredGems = "2500GEMS"
    public static let fiveThousandGems = "5000GEMS"
    
    private static let productIdentifiers: Set<ProductIdentifier> = [FlappyProducts.PremiumFlappy, FlappyProducts.thousandGems, FlappyProducts.twentyFiveHundredGems, FlappyProducts.fiveThousandGems]
    
    public static let store = IAPHelper(productIds: FlappyProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
    return productIdentifier.components(separatedBy: ".").last
}
