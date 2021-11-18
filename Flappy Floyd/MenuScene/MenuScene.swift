//
//  MenuScene.swift
//  Flappy Floyd
//
//  Created by Dustin Moore on 11/14/19.
//  Copyright © 2019 Dustin Moore. All rights reserved.
//

import SpriteKit
import GameKit
import GameplayKit
import GoogleMobileAds
import StoreKit

class MenuScene: SKScene, SKPhysicsContactDelegate, GADInterstitialDelegate, GKGameCenterControllerDelegate {
    
    var userDefaults = UserDefaults.standard
    var flappyGameMode = UserDefaults.standard.integer(forKey: "flappyGameMode")
    var gameModeButton = SKSpriteNode()
    var soundOnBtn = SKSpriteNode()
    var soundOn = UserDefaults.standard.integer(forKey: "flappySound")
    
    override func didMove(to view: SKView) {
        gameModeButton = (self.childNode(withName: "gameMode") as! SKSpriteNode)
        soundOnBtn = (self.childNode(withName: "sound") as! SKSpriteNode)
        
        if !isKeyPresentInUserDefaults(key: "flappyGameMode") {
            userDefaults.set(1, forKey: "flappyGameMode")
            userDefaults.synchronize()
            flappyGameMode = 1
        }
        
        if !isKeyPresentInUserDefaults(key: "flappySound") {
            userDefaults.set(1, forKey: "flappySound")
            userDefaults.synchronize()
            soundOn = 1
        }
        
        if flappyGameMode == 1 {
            gameModeButton.texture = SKTexture(imageNamed: "normal-mode")
        } else {
            gameModeButton.texture = SKTexture(imageNamed: "progressive-mode")
        }
        
        if soundOn == 1 {
            soundOnBtn.texture = SKTexture(imageNamed: "main-menu-sound")
        } else {
            soundOnBtn.texture = SKTexture(imageNamed: "sound-off")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
                        
            if nodesArray.first?.name == "playGame" {
                if flappyGameMode == 1 {
                    let transition = SKTransition.crossFade(withDuration: 0.5)
                    let gameScene = GameScene(size: view!.bounds.size)
                    self.view?.presentScene(gameScene, transition: transition)
                } else {
                    let transition = SKTransition.crossFade(withDuration: 0.5)
                    let chooseLevelScene = ChooseLevelScene(fileNamed:"ChooseLevelScene")
                    chooseLevelScene?.scaleMode = .fill
                    self.view?.presentScene(chooseLevelScene!, transition: transition)
                }
            } else if nodesArray.first?.name == "skins" {
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let skinScene = SkinScene(fileNamed:"SkinScene")
                skinScene?.scaleMode = .fill
                self.view?.presentScene(skinScene!, transition: transition)
            } else if nodesArray.first?.name == "gameMode" {
                changeGameMode()
            } else if nodesArray.first?.name == "leaderboards" {
                showLeader()
            } else if nodesArray.first?.name == "sound" {
                manageGameSound()
            } else if nodesArray.first?.name == "store" {
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let shopScene = ShopScene(fileNamed:"ShopScene")
                shopScene?.scaleMode = .fill
                self.view?.presentScene(shopScene!, transition: transition)
            }
        }
    }
    
    func manageGameSound() {
        if soundOn == 1 {
            soundOnBtn.texture = SKTexture(imageNamed: "main-menu-sound")
            userDefaults.set(0, forKey: "flappySound")
            userDefaults.synchronize()
            soundOn = 0
        } else {
            soundOnBtn.texture = SKTexture(imageNamed: "sound-off")
            userDefaults.set(1, forKey: "flappySound")
            userDefaults.synchronize()
            soundOn = 1
        }
    }
    
    func changeGameMode() {
        if flappyGameMode == 1 {
            gameModeButton.texture = SKTexture(imageNamed: "progressive-mode")
            userDefaults.set(2, forKey: "flappyGameMode")
            userDefaults.synchronize()
            flappyGameMode = 2
        } else if flappyGameMode == 2 {
            gameModeButton.texture = SKTexture(imageNamed: "normal-mode")
            userDefaults.set(1, forKey: "flappyGameMode")
            userDefaults.synchronize()
            flappyGameMode = 1
        }
    }
    
    //shows leaderboard screen
    func showLeader() {
        let viewControllerVar = self.view?.window?.rootViewController
        let gKGCViewController = GKGameCenterViewController()
        gKGCViewController.gameCenterDelegate = self as GKGameCenterControllerDelegate
        viewControllerVar?.present(gKGCViewController, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
