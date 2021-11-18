//
//  ShopScene.swift
//  Flappy Floyd
//
//  Created by Dustin Moore on 12/28/19.
//  Copyright © 2019 Dustin Moore. All rights reserved.
//

import SpriteKit
import GameKit
import GameplayKit
import GoogleMobileAds
import StoreKit

class ShopScene: SKScene {
    
    let iCloudDefaults = NSUbiquitousKeyValueStore.default
    var shopMode = 0
    var gems = NSUbiquitousKeyValueStore.default.object(forKey: "gems") as? Int
    
    // shop buttons
    var gemsButton = SKSpriteNode()
    var adsButton = SKSpriteNode()
    var homeButton = SKSpriteNode()
    var restorePurchasesButton = SKSpriteNode()
    
    // purchase buttons
    var shopSquare1 = SKSpriteNode()
    var shopSquare2 = SKSpriteNode()
    var shopSquare3 = SKSpriteNode()
    
    //gem label
    var gemsAvailable = SKLabelNode()
    
    override func didMove(to view: SKView) {
        gemsButton = (self.childNode(withName: "gemsButton") as! SKSpriteNode)
        adsButton = (self.childNode(withName: "adsButton") as! SKSpriteNode)
        
        shopSquare1 = (self.childNode(withName: "shopSquare1") as! SKSpriteNode)
        shopSquare2 = (self.childNode(withName: "shopSquare2") as! SKSpriteNode)
        shopSquare3 = (self.childNode(withName: "shopSquare3") as! SKSpriteNode)
        
        gemsAvailable = (self.childNode(withName: "gemsAvailable") as! SKLabelNode)
        gemsAvailable.text = "\(gems ?? 0)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
                        
            if nodesArray.first?.name == "adsButton" {
                shopMode = 1
                shopSquare1.texture = SKTexture(imageNamed: "no-ads-square")
                shopSquare2.texture = SKTexture(imageNamed: "premium-square")
                shopSquare3.alpha = 0.0
            } else if nodesArray.first?.name == "gemsButton" {
                shopMode = 0
                shopSquare1.texture = SKTexture(imageNamed: "purchase-1k-square")
                shopSquare2.texture = SKTexture(imageNamed: "purchase-2500-square")
                shopSquare3.alpha = 1.0
            } else if nodesArray.first?.name == "shopSquare1" {
                if shopMode == 0 {
                    let product = SKProduct(identifier: "1000GEMS")
                    FlappyProducts.store.buyProduct(product)
                    let waitForPurchase = SKAction.wait(forDuration: 10)
                    gemsAvailable.run(waitForPurchase) {
                        self.gemsAvailable.text = "\(self.iCloudDefaults.object(forKey: "gems") ?? 0)"
                    }
                } else {
                    let product = SKProduct(identifier: "NOADSFLAPPY2019")
                    FlappyProducts.store.buyProduct(product)
                }
            } else if nodesArray.first?.name == "shopSquare2" {
                if shopMode == 0 {
                    let product = SKProduct(identifier: "2500GEMS")
                    FlappyProducts.store.buyProduct(product)
                    let waitForPurchase = SKAction.wait(forDuration: 10)
                    gemsAvailable.run(waitForPurchase) {
                        self.gemsAvailable.text = "\(self.iCloudDefaults.object(forKey: "gems") ?? 0)"
                    }
                } else {
                    let product = SKProduct(identifier: "PREMIUMFLOYD2019")
                    FlappyProducts.store.buyProduct(product)
                    let waitForPurchase = SKAction.wait(forDuration: 10)
                    gemsAvailable.run(waitForPurchase) {
                        self.gemsAvailable.text = "\(self.iCloudDefaults.object(forKey: "gems") ?? 0)"
                    }
                }
            } else if nodesArray.first?.name == "shopSquare3" {
                if shopMode == 0 {
                    let product = SKProduct(identifier: "5000GEMS")
                    FlappyProducts.store.buyProduct(product)
                    let waitForPurchase = SKAction.wait(forDuration: 10)
                    gemsAvailable.run(waitForPurchase) {
                        self.gemsAvailable.text = "\(self.iCloudDefaults.object(forKey: "gems") ?? 0)"
                    }
                }
            } else if nodesArray.first?.name == "restorePurchasesButton" {
                FlappyProducts.store.restorePurchases()
            } else if nodesArray.first?.name == "homeButton" {
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let menuScene = MenuScene(fileNamed:"MenuScene")
                menuScene?.scaleMode = .fill
                self.view?.presentScene(menuScene!, transition: transition)
            }
        }
    }
}
