//
//  ChooseLevelScene.swift
//  Flappy Floyd
//
//  Created by Dustin Moore on 12/29/19.
//  Copyright © 2019 Dustin Moore. All rights reserved.
//

import SpriteKit
import GameKit
import GameplayKit
import GoogleMobileAds
import StoreKit

class ChooseLevelScene: SKScene, GKGameCenterControllerDelegate {
    
    // buttons
    var homeButton = SKSpriteNode()
    var soundButton = SKSpriteNode()
    var leaderBoardButton = SKSpriteNode()
    var shopButton = SKSpriteNode()
    
    // level buttons
    var level1 = SKSpriteNode()
    var level2 = SKSpriteNode()
    var level3 = SKSpriteNode()
    var level4 = SKSpriteNode()
    var level5 = SKSpriteNode()
    var level6 = SKSpriteNode()
    var level7 = SKSpriteNode()
    var level8 = SKSpriteNode()
    var level9 = SKSpriteNode()
    var level10 = SKSpriteNode()
    var level11 = SKSpriteNode()
    var level12 = SKSpriteNode()
    var level13 = SKSpriteNode()
    var level14 = SKSpriteNode()
    var level15 = SKSpriteNode()
    
    var userDefaults = UserDefaults.standard
    var soundOn = UserDefaults.standard.integer(forKey: "flappySound")
    var chosenLevel = 1
    	
    override func didMove(to view: SKView) {
        
        soundButton = (self.childNode(withName: "soundButton") as! SKSpriteNode)
        
        if soundOn == 1 {
            soundButton.texture = SKTexture(imageNamed: "mini-sound")
        } else {
            soundButton.texture = SKTexture(imageNamed: "mini-sound-off")
        }
        
        level1 = (self.childNode(withName: "level1") as! SKSpriteNode)
        level2 = (self.childNode(withName: "level2") as! SKSpriteNode)
        level3 = (self.childNode(withName: "level3") as! SKSpriteNode)
        level4 = (self.childNode(withName: "level4") as! SKSpriteNode)
        level5 = (self.childNode(withName: "level5") as! SKSpriteNode)
        level6 = (self.childNode(withName: "level6") as! SKSpriteNode)
        level7 = (self.childNode(withName: "level7") as! SKSpriteNode)
        level8 = (self.childNode(withName: "level8") as! SKSpriteNode)
        level9 = (self.childNode(withName: "level9") as! SKSpriteNode)
        level10 = (self.childNode(withName: "level10") as! SKSpriteNode)
        level11 = (self.childNode(withName: "level11") as! SKSpriteNode)
        level12 = (self.childNode(withName: "level12") as! SKSpriteNode)
        level13 = (self.childNode(withName: "level13") as! SKSpriteNode)
        level14 = (self.childNode(withName: "level14") as! SKSpriteNode)
        level15 = (self.childNode(withName: "level15") as! SKSpriteNode)
        
        if !isKeyPresentInUserDefaults(key: "level1Complete") {
            userDefaults.set(0, forKey: "level1Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level1Complete") == 1 {
            level1.texture = SKTexture(imageNamed: "level-1-complete")
            level2.texture = SKTexture(imageNamed: "level-2")
        }
        
        if !isKeyPresentInUserDefaults(key: "level2Complete") {
            userDefaults.set(0, forKey: "level2Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level2Complete") == 1 {
            level2.texture = SKTexture(imageNamed: "level-2-complete")
            level3.texture = SKTexture(imageNamed: "level-3")
        }
        
        if !isKeyPresentInUserDefaults(key: "level3Complete") {
            userDefaults.set(0, forKey: "level3Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level3Complete") == 1 {
            level3.texture = SKTexture(imageNamed: "level-3-complete")
            level4.texture = SKTexture(imageNamed: "level-4")
        }
        
        if !isKeyPresentInUserDefaults(key: "level4Complete") {
            userDefaults.set(0, forKey: "level4Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level4Complete") == 1 {
            level4.texture = SKTexture(imageNamed: "level-4-complete")
            level5.texture = SKTexture(imageNamed: "level-5")
        }
        
        if !isKeyPresentInUserDefaults(key: "level5Complete") {
            userDefaults.set(0, forKey: "level5Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level5Complete") == 1 {
            level5.texture = SKTexture(imageNamed: "level-5-complete")
            level6.texture = SKTexture(imageNamed: "level-6")
        }
        
        if !isKeyPresentInUserDefaults(key: "level6Complete") {
            userDefaults.set(0, forKey: "level6Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level6Complete") == 1 {
            level6.texture = SKTexture(imageNamed: "level-6-complete")
            level7.texture = SKTexture(imageNamed: "level-7")
        }
        
        if !isKeyPresentInUserDefaults(key: "level7Complete") {
            userDefaults.set(0, forKey: "level7Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level7Complete") == 1 {
            level7.texture = SKTexture(imageNamed: "level-7-complete")
            level8.texture = SKTexture(imageNamed: "level-8")
        }
        
        if !isKeyPresentInUserDefaults(key: "level8Complete") {
            userDefaults.set(0, forKey: "level8Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level8Complete") == 1 {
            level8.texture = SKTexture(imageNamed: "level-8-complete")
            level9.texture = SKTexture(imageNamed: "level-9")
        }
        
        
        if !isKeyPresentInUserDefaults(key: "level9Complete") {
            userDefaults.set(0, forKey: "level9Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level9Complete") == 1 {
            level9.texture = SKTexture(imageNamed: "level-9-complete")
            level10.texture = SKTexture(imageNamed: "level-10")
        }
        
        if !isKeyPresentInUserDefaults(key: "level10Complete") {
            userDefaults.set(0, forKey: "level10Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level10Complete") == 1 {
            level10.texture = SKTexture(imageNamed: "level-10-complete")
            level11.texture = SKTexture(imageNamed: "level-11")
        }
        
        if !isKeyPresentInUserDefaults(key: "level11Complete") {
            userDefaults.set(0, forKey: "level11Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level11Complete") == 1 {
            level11.texture = SKTexture(imageNamed: "level-11-complete")
            level12.texture = SKTexture(imageNamed: "level-12")
        }
        
        if !isKeyPresentInUserDefaults(key: "level12Complete") {
            userDefaults.set(0, forKey: "level12Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level12Complete") == 1 {
            level12.texture = SKTexture(imageNamed: "level-12-complete")
            level13.texture = SKTexture(imageNamed: "level-13")
        }
        
        if !isKeyPresentInUserDefaults(key: "level13Complete") {
            userDefaults.set(0, forKey: "level13Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level13Complete") == 1 {
            level13.texture = SKTexture(imageNamed: "level-13-complete")
            level14.texture = SKTexture(imageNamed: "level-14")
        }
        
        if !isKeyPresentInUserDefaults(key: "level14Complete") {
            userDefaults.set(0, forKey: "level14Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level14Complete") == 1 {
            level14.texture = SKTexture(imageNamed: "level-14-complete")
            level15.texture = SKTexture(imageNamed: "level-15")
        }
        
        if !isKeyPresentInUserDefaults(key: "level15Complete") {
            userDefaults.set(0, forKey: "level15Complete")
            userDefaults.synchronize()
        } else if UserDefaults.standard.integer(forKey: "level15Complete") == 1 {
            level15.texture = SKTexture(imageNamed: "level-15-complete")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "homeButton" {
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let menuScene = MenuScene(fileNamed:"MenuScene")
                menuScene?.scaleMode = .fill
                self.view?.presentScene(menuScene!, transition: transition)
            } else if nodesArray.first?.name == "soundButton" {
                manageGameSound()
            } else if nodesArray.first?.name == "leaderBoardButton" {
                showLeader()
            } else if nodesArray.first?.name == "shopButton" {
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let shopScene = ShopScene(fileNamed:"ShopScene")
                shopScene?.scaleMode = .fill
                self.view?.presentScene(shopScene!, transition: transition)
            } else if nodesArray.first?.name == "level1" {
                startProperLevel(level: 1)
            } else if nodesArray.first?.name == "level2" {
                if UserDefaults.standard.integer(forKey: "level1Complete") == 1 {
                    startProperLevel(level: 2)
                }
            } else if nodesArray.first?.name == "level3" {
                if UserDefaults.standard.integer(forKey: "level1Complete") == 1 {
                    startProperLevel(level: 3)
                }
            } else if nodesArray.first?.name == "level4" {
                if UserDefaults.standard.integer(forKey: "level1Complete") == 1 {
                    startProperLevel(level: 4)
                }
            } else if nodesArray.first?.name == "level5" {
                if UserDefaults.standard.integer(forKey: "level1Complete") == 1 {
                    startProperLevel(level: 5)
                }
            } else if nodesArray.first?.name == "level6" {
                if UserDefaults.standard.integer(forKey: "level1Complete") == 1 {
                    startProperLevel(level: 6)
                }
            } else if nodesArray.first?.name == "level7" {
                if UserDefaults.standard.integer(forKey: "level1Complete") == 1 {
                    startProperLevel(level: 7)
                }
            } else if nodesArray.first?.name == "level8" {
                if UserDefaults.standard.integer(forKey: "level1Complete") == 1 {
                    startProperLevel(level: 8)
                }
            } else if nodesArray.first?.name == "level9" {
                if UserDefaults.standard.integer(forKey: "level1Complete") == 1 {
                    startProperLevel(level: 9)
                }
            } else if nodesArray.first?.name == "level10" {
                if UserDefaults.standard.integer(forKey: "level1Complete") == 1 {
                    startProperLevel(level: 10)
                }
            } else if nodesArray.first?.name == "level11" {
                if UserDefaults.standard.integer(forKey: "level1Complete") == 1 {
                    startProperLevel(level: 11)
                }
            } else if nodesArray.first?.name == "level12" {
                if UserDefaults.standard.integer(forKey: "level1Complete") == 1 {
                    startProperLevel(level: 12)
                }
            } else if nodesArray.first?.name == "level13" {
                if UserDefaults.standard.integer(forKey: "level1Complete") == 1 {
                    startProperLevel(level: 13)
                }
            } else if nodesArray.first?.name == "level14" {
                if UserDefaults.standard.integer(forKey: "level1Complete") == 1 {
                    startProperLevel(level: 14)
                }
            } else if nodesArray.first?.name == "level15" {
                if UserDefaults.standard.integer(forKey: "level14Complete") == 1 {
                    startProperLevel(level: 15)
                }
            }
            
        }
    }
    
    func startProperLevel(level: Int) {
        userDefaults.set(level, forKey: "chosenLevel")
        userDefaults.synchronize()
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let progressiveGameScene = ProgressiveGameScene(size: view!.bounds.size)
        self.view?.presentScene(progressiveGameScene, transition: transition)
    }
    
    func manageGameSound() {
        if soundOn == 1 {
            soundButton.texture = SKTexture(imageNamed: "mini-sound")
            userDefaults.set(0, forKey: "flappySound")
            userDefaults.synchronize()
            soundOn = 0
        } else {
            soundButton.texture = SKTexture(imageNamed: "mini-sound-off")
            userDefaults.set(1, forKey: "flappySound")
            userDefaults.synchronize()
            soundOn = 1
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
