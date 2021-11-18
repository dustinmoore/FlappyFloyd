//
//  SkinScene.swift
//  Flappy Floyd
//
//  Created by Dustin Moore on 10/29/19.
//  Copyright © 2019 Dustin Moore. All rights reserved.
//

import GameKit
import GameplayKit
import GoogleMobileAds

class SkinScene: SKScene {
            
    let iCloudDefaults = NSUbiquitousKeyValueStore.default
    
    var gems = NSUbiquitousKeyValueStore.default.object(forKey: "gems") as? Int
    
    var activeSkin: Int = NSUbiquitousKeyValueStore.default.object(forKey: "activeSkin") as? Int ?? 1
    
    //skin buttons
    var angryButton = SKSpriteNode()
    var albinoButton = SKSpriteNode()
    var baseballButton = SKSpriteNode()
    var santaButton = SKSpriteNode()
    var ninjaButton = SKSpriteNode()
    var bazookaButton = SKSpriteNode()
    var slappyButton = SKSpriteNode()
    var adventureButton = SKSpriteNode()
    var pirateButton = SKSpriteNode()
    var spookyButton = SKSpriteNode()
    var thankfulButton = SKSpriteNode()
    
    //skin frames
    var flappySkin = SKSpriteNode()
    var angrySkin = SKSpriteNode()
    var albinoSkin = SKSpriteNode()
    var baseballSkin = SKSpriteNode()
    var santaSkin = SKSpriteNode()
    var ninjaSkin = SKSpriteNode()
    var bazookaSkin = SKSpriteNode()
    var slappySkin = SKSpriteNode()
    var adventureSkin = SKSpriteNode()
    var pirateSkin = SKSpriteNode()
    var spookySkin = SKSpriteNode()
    var thankfulSkin = SKSpriteNode()
    
    //gem label
    var gemsAvailable = SKLabelNode()
    
    override func didMove(to view: SKView) {
        //skin buttons
        angryButton = (self.childNode(withName: "angryButton") as! SKSpriteNode)
        albinoButton = (self.childNode(withName: "albinoButton") as! SKSpriteNode)
        baseballButton = (self.childNode(withName: "baseballButton") as! SKSpriteNode)
        santaButton = (self.childNode(withName: "santaButton") as! SKSpriteNode)
        ninjaButton = (self.childNode(withName: "ninjaButton") as! SKSpriteNode)
        bazookaButton = (self.childNode(withName: "bazookaButton") as! SKSpriteNode)
        slappyButton = (self.childNode(withName: "slappyButton") as! SKSpriteNode)
        adventureButton = (self.childNode(withName: "adventureButton") as! SKSpriteNode)
        pirateButton = (self.childNode(withName: "pirateButton") as! SKSpriteNode)
        spookyButton = (self.childNode(withName: "spookyButton") as! SKSpriteNode)
        thankfulButton = (self.childNode(withName: "thankfulButton") as! SKSpriteNode)
        
        //skin frames
        flappySkin = (self.childNode(withName: "flappy") as! SKSpriteNode)
        angrySkin = (self.childNode(withName: "angry") as! SKSpriteNode)
        albinoSkin = (self.childNode(withName: "albino") as! SKSpriteNode)
        baseballSkin = (self.childNode(withName: "baseball") as! SKSpriteNode)
        santaSkin = (self.childNode(withName: "santa") as! SKSpriteNode)
        ninjaSkin = (self.childNode(withName: "ninja") as! SKSpriteNode)
        bazookaSkin = (self.childNode(withName: "bazooka") as! SKSpriteNode)
        slappySkin = (self.childNode(withName: "slappy") as! SKSpriteNode)
        adventureSkin = (self.childNode(withName: "adventure") as! SKSpriteNode)
        pirateSkin = (self.childNode(withName: "pirate") as! SKSpriteNode)
        spookySkin = (self.childNode(withName: "spooky") as! SKSpriteNode)
        thankfulSkin = (self.childNode(withName: "thankful") as! SKSpriteNode)
        
        gemsAvailable = (self.childNode(withName: "gemsAvailable") as! SKLabelNode)
        gemsAvailable.text = "\(gems ?? 0)"
        
        // highlight active skin
        highlightActiveSkin()
        
        if iCloudDefaults.object(forKey: "skin2") as? Int == 1 {
            angryButton.texture = SKTexture(imageNamed: "choose-1")
        }
        
        if iCloudDefaults.object(forKey: "skin3") as? Int == 1 {
            albinoButton.texture = SKTexture(imageNamed: "choose-1")
        }
        
        if iCloudDefaults.object(forKey: "skin4") as? Int == 1 {
            baseballButton.texture = SKTexture(imageNamed: "choose-1")
        }
        
        if iCloudDefaults.object(forKey: "skin5") as? Int == 1 {
            santaButton.texture = SKTexture(imageNamed: "choose-1")
        }
        
        if iCloudDefaults.object(forKey: "skin6") as? Int == 1 {
            ninjaButton.texture = SKTexture(imageNamed: "choose-1")
        }
        
        if iCloudDefaults.object(forKey: "skin7") as? Int == 1 {
            bazookaButton.texture = SKTexture(imageNamed: "choose-1")
        }
        
        if iCloudDefaults.object(forKey: "skin8") as? Int == 1 {
            slappyButton.texture = SKTexture(imageNamed: "choose-1")
        }
        
        if iCloudDefaults.object(forKey: "skin9") as? Int == 1 {
            adventureButton.texture = SKTexture(imageNamed: "choose-1")
        }
        
        if iCloudDefaults.object(forKey: "skin10") as? Int == 1 {
            pirateButton.texture = SKTexture(imageNamed: "choose-1")
        }
        
        if iCloudDefaults.object(forKey: "skin11") as? Int == 1 {
            spookyButton.texture = SKTexture(imageNamed: "choose-1")
        }
        
        if iCloudDefaults.object(forKey: "skin12") as? Int == 1 {
            thankfulButton.texture = SKTexture(imageNamed: "choose-1")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if touchedNode.name == "flappyButton" {
            handleChooseSkin(skinNumber: 1)
        }
        
        if touchedNode.name == "angryButton" {
            handleSkinButtonTouches(skinNode: touchedNode as! SKSpriteNode, skinNumber: 2, gemCost: 1000)
        }
        
        if touchedNode.name == "albinoButton" {
            handleSkinButtonTouches(skinNode: touchedNode as! SKSpriteNode, skinNumber: 3, gemCost: 1000)
        }
        
        if touchedNode.name == "baseballButton" {
            handleSkinButtonTouches(skinNode: touchedNode as! SKSpriteNode, skinNumber: 4, gemCost: 500)
        }
        
        if touchedNode.name == "santaButton" {
            handleSkinButtonTouches(skinNode: touchedNode as! SKSpriteNode, skinNumber: 5, gemCost: 1000)
        }
        
        if touchedNode.name == "ninjaButton" {
            handleSkinButtonTouches(skinNode: touchedNode as! SKSpriteNode, skinNumber: 6, gemCost: 1000)
        }
        
        if touchedNode.name == "bazookaButton" {
            handleSkinButtonTouches(skinNode: touchedNode as! SKSpriteNode, skinNumber: 7, gemCost: 500)
        }
        
        if touchedNode.name == "slappyButton" {
            handleSkinButtonTouches(skinNode: touchedNode as! SKSpriteNode, skinNumber: 8, gemCost: 500)
        }
        
        if touchedNode.name == "adventureButton" {
            handleSkinButtonTouches(skinNode: touchedNode as! SKSpriteNode, skinNumber: 9, gemCost: 500)
        }
        
        if touchedNode.name == "pirateButton" {
            handleSkinButtonTouches(skinNode: touchedNode as! SKSpriteNode, skinNumber: 10, gemCost: 1000)
        }
        
        if touchedNode.name == "spookyButton" {
            handleSkinButtonTouches(skinNode: touchedNode as! SKSpriteNode, skinNumber: 11, gemCost: 1500)
        }
        
        if touchedNode.name == "thankfulButton" {
            handleSkinButtonTouches(skinNode: touchedNode as! SKSpriteNode, skinNumber: 12, gemCost: 1000)
        }               
        
        if touchedNode.name == "shopButton" {
            let transition = SKTransition.crossFade(withDuration: 0.5)
            let shopScene = ShopScene(fileNamed:"ShopScene")
            shopScene?.scaleMode = .fill
            self.view?.presentScene(shopScene!, transition: transition)
        }
        
        if touchedNode.name == "homeButton" {
            presentMainScene()
        }
    }
    
    func presentMainScene() {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let menuScene = MenuScene(fileNamed:"MenuScene")
        menuScene?.scaleMode = .fill
        self.view?.presentScene(menuScene!, transition: transition)
    }
    
    func handleSkinButtonTouches(skinNode: SKSpriteNode, skinNumber: Int, gemCost: Int) {
        let skinAvailable = iCloudDefaults.object(forKey: "skin\(skinNumber)") as? Int
        if skinAvailable == 1 {
            handleChooseSkin(skinNumber: skinNumber)
        } else {
            if gems! >= gemCost {
                skinNode.texture = SKTexture(imageNamed: "choose-1")
                gems! = gems! - gemCost
                iCloudDefaults.set(gems!, forKey: "gems")
                iCloudDefaults.set(1, forKey: "skin\(skinNumber)")
                iCloudDefaults.synchronize()
                gemsAvailable.text = "\(iCloudDefaults.object(forKey: "gems") ?? 0)"
                                        
            } else {
                let alert = UIAlertController(title: "Not Enough Gems", message: "You don't have enough gems to unlock this Floyd skin. \(gemCost) Gems are required.", preferredStyle: UIAlertController.Style.actionSheet)
                alert.addAction(UIAlertAction(title: "ok", style: .destructive))
                self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func handleChooseSkin(skinNumber: Int) {
        iCloudDefaults.set(skinNumber, forKey: "activeSkin")
        iCloudDefaults.synchronize()
        presentMainScene()
    }
    
    func highlightActiveSkin() {
        if activeSkin == 1 {
            flappySkin.alpha = 1.0
        } else {
            flappySkin.alpha = 0.5
        }
        
        if activeSkin == 2 {
            angrySkin.alpha = 1.0
        } else {
            angrySkin.alpha = 0.5
        }
        
        if activeSkin == 3 {
            albinoSkin.alpha = 1.0
        } else {
            albinoSkin.alpha = 0.5
        }
        
        if activeSkin == 4 {
            baseballSkin.alpha = 1.0
        } else {
            baseballSkin.alpha = 0.5
        }
        
        if activeSkin == 5 {
            santaSkin.alpha = 1.0
        } else {
            santaSkin.alpha = 0.5
        }
        
        if activeSkin == 6 {
            ninjaSkin.alpha = 1.0
        } else {
            ninjaSkin.alpha = 0.5
        }
        
        if activeSkin == 7 {
            bazookaSkin.alpha = 1.0
        } else {
            bazookaSkin.alpha = 0.5
        }
        
        if activeSkin == 8 {
            slappySkin.alpha = 1.0
        } else {
            slappySkin.alpha = 0.5
        }
        
        if activeSkin == 9 {
            adventureSkin.alpha = 1.0
        } else {
            adventureSkin.alpha = 0.5
        }
        
        if activeSkin == 10 {
            pirateSkin.alpha = 1.0
        } else {
            pirateSkin.alpha = 0.5
        }
        
        if activeSkin == 11 {
            spookySkin.alpha = 1.0
        } else {
            spookySkin.alpha = 0.5
        }
        
        if activeSkin == 12 {
            thankfulSkin.alpha = 1.0
        } else {
            thankfulSkin.alpha = 0.5
        }
    }
}
