//
//  GameScene.swift
//  Flappy Floyd
//
//  Created by Dustin Moore on 10/25/19.
//  Copyright © 2019 Dustin Moore. All rights reserved.
//

import SpriteKit
import GameKit
import GameplayKit
import GoogleMobileAds
import StoreKit

class GameScene: SKScene, SKPhysicsContactDelegate, GADInterstitialDelegate, GKGameCenterControllerDelegate {
    
    var interstitial: GADInterstitial!
    
    var isGameStarted = Bool(false)
    var isDied = Bool(false)
    let impactSound = SKAction.playSoundFileNamed("gems.mp3", waitForCompletion: false)
    let fallingSound = SKAction.playSoundFileNamed("fall.mp3", waitForCompletion: false)
    
    var levelGoal: Int = 0
    var levelChange: Bool = false
    var levelTransition: Bool = false
    var level: Int = 1
    var blockNumber: Int = 1
    var score: Int = 0
    var uiBkg = SKSpriteNode()
    var gemsLbl = SKLabelNode()
    var scoreLbl = SKLabelNode()
    var levelLbl = SKLabelNode()
    var pauseLabel = SKLabelNode()
    var highscoreLbl = SKLabelNode()
    var taptoplayLbl = SKLabelNode()
    var homeBtn = SKSpriteNode()
    var restartBtn = SKSpriteNode()
    var continueBtn = SKSpriteNode()
    var rateAppButton = SKSpriteNode()
    var logoImg = SKSpriteNode()
    var wallPair = SKNode()
    var moveAndRemove = SKAction()
    var sparkEmmiter = SKEmitterNode()
    var canCreateScene: Bool = false
    var soundOffBtn = SKSpriteNode()
    var soundOnBtn = SKSpriteNode()
    
    var background = SKSpriteNode(imageNamed: "level1")
    var levelBackgroundFaderNode = SKSpriteNode()
    
    //CREATE THE TURTLE ATLAS FOR ANIMATION
    var turtleAtlas = SKTextureAtlas()
    var turtleSprites = Array<Any>()
    var turtle = SKSpriteNode()
    var repeatActionTurtle = SKAction()
    
    let iCloudDefaults = NSUbiquitousKeyValueStore.default
    var activeSkin: Int = NSUbiquitousKeyValueStore.default.object(forKey: "activeSkin") as? Int ?? 1
    
    let backgroundSound = SKAudioNode(fileNamed: "pimpoy.wav")
    
    var delay = SKAction()
    var isGameContinued: Bool = false
    
    var soundOn = UserDefaults.standard.integer(forKey: "flappySound")
    
    override func didMove(to view: SKView) {
        backgroundSound.name = "backgroundSound"
        
        if !isKeyPresentInCloud(key: "activeSkin") {
            iCloudDefaults.set(1, forKey: "activeSkin")
        }
        if !isKeyPresentInCloud(key: "skin1") {
            iCloudDefaults.set(1, forKey: "skin1")
        }
        if !isKeyPresentInCloud(key: "skin2") {
            iCloudDefaults.set(0, forKey: "skin2")
        }
        if !isKeyPresentInCloud(key: "skin3") {
            iCloudDefaults.set(0, forKey: "skin3")
        }
        if !isKeyPresentInCloud(key: "skin4") {
            iCloudDefaults.set(0, forKey: "skin4")
        }
        if !isKeyPresentInCloud(key: "skin5") {
            iCloudDefaults.set(0, forKey: "skin5")
        }
        if !isKeyPresentInCloud(key: "skin6") {
            iCloudDefaults.set(0, forKey: "skin6")
        }
        if !isKeyPresentInCloud(key: "skin7") {
            iCloudDefaults.set(0, forKey: "skin7")
        }
        if !isKeyPresentInCloud(key: "skin8") {
            iCloudDefaults.set(0, forKey: "skin8")
        }
        if !isKeyPresentInCloud(key: "skin9") {
            iCloudDefaults.set(0, forKey: "skin9")
        }
        if !isKeyPresentInCloud(key: "skin10") {
            iCloudDefaults.set(0, forKey: "skin10")
        }
        if !isKeyPresentInCloud(key: "skin11") {
            iCloudDefaults.set(0, forKey: "skin11")
        }
        if !isKeyPresentInCloud(key: "skin12") {
            iCloudDefaults.set(0, forKey: "skin12")
        }
        if !isKeyPresentInCloud(key: "highScore") {
            iCloudDefaults.set(0, forKey: "highScore")
        }
        if !isKeyPresentInCloud(key: "gems") {
            iCloudDefaults.set(0, forKey: "gems")
        }
        if !FlappyProducts.store.isProductPurchased("PREMIUMFLOYD2019") && !FlappyProducts.store.isProductPurchased("NOADSFLAPPY2019") {
            interstitial = createAndLoadInterstitial()
        }
        
        // RECURSIVELY ACTIVATE ALL SKINS FOR PREMIUM PURCHASERS
        if FlappyProducts.store.isProductPurchased("PREMIUMFLOYD2019") {
            iCloudDefaults.set(1, forKey: "skin2")
            iCloudDefaults.set(1, forKey: "skin3")
            iCloudDefaults.set(1, forKey: "skin4")
            iCloudDefaults.set(1, forKey: "skin5")
            iCloudDefaults.set(1, forKey: "skin6")
            iCloudDefaults.set(1, forKey: "skin7")
            iCloudDefaults.set(1, forKey: "skin8")
            iCloudDefaults.set(1, forKey: "skin9")
            iCloudDefaults.set(1, forKey: "skin10")
            iCloudDefaults.set(1, forKey: "skin11")
            iCloudDefaults.set(1, forKey: "skin12")
            iCloudDefaults.synchronize()
        }
        
        iCloudDefaults.synchronize()
        turtleAtlas = SKTextureAtlas(named: "skin\(activeSkin)")
        createScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDied {
            for touch in touches {
                let location = touch.location(in: self)
                let touchedNode = self.atPoint(location)
                
                if continueBtn.contains(location) {
                    let gems = (iCloudDefaults.object(forKey: "gems") as? Int)!
                    if gems >= 500 {
                        iCloudDefaults.set(gems - 500, forKey: "gems")
                        iCloudDefaults.synchronize()
                        gemsLbl.text = "Gems Available: \(iCloudDefaults.object(forKey: "gems") ?? 0)"
                        isGameContinued = true
                        restartScene()
                    } else {
                        let alert = UIAlertController(title: "Not Enough Gems", message: "You don't have enough gems to continue this game. 500 Gems are required.", preferredStyle: UIAlertController.Style.actionSheet)
                        alert.addAction(UIAlertAction(title: "ok", style: .destructive))
                        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                    }
                }
                
                if restartBtn.contains(location){
                    level = 1
                    levelGoal = 0
                    isGameContinued = false
                    restartScene()
                }
                
                if touchedNode.name == "homeBtn" {
                    let transition = SKTransition.crossFade(withDuration: 0.5)
                    let menuScene = MenuScene(fileNamed:"MenuScene")
                    menuScene?.scaleMode = .fill
                    self.view?.presentScene(menuScene!, transition: transition)
                }
            }
        } else if isGameStarted == false {
            let touch:UITouch = touches.first!
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if touchedNode.name == "homeBtn" {
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let menuScene = MenuScene(fileNamed:"MenuScene")
                menuScene?.scaleMode = .fill
                self.view?.presentScene(menuScene!, transition: transition)
            } else {
                isGameStarted =  true
                turtle.physicsBody?.affectedByGravity = true
                
                if (soundOn == 1) {
                    self.addChild(backgroundSound)
                }
                
                logoImg.run(SKAction.scale(to: 0.5, duration: 0.3), completion: {
                    self.logoImg.removeFromParent()
                })
                taptoplayLbl.removeFromParent()
                
                self.turtle.run(repeatActionTurtle)
                
                let spawn = SKAction.run({
                    () in
                    self.wallPair = self.createWalls()
                    self.addChild(self.wallPair)
                })
                
                delay = SKAction.wait(forDuration: 1.5)
                
                let SpawnDelay = SKAction.sequence([spawn, delay])
                let spawnDelayForever = SKAction.repeatForever(SpawnDelay)
                self.run(spawnDelayForever)
                
                let distance = CGFloat(self.frame.width + wallPair.frame.width)
                let moveblockss = SKAction.moveBy(x: -distance - 50, y: 0, duration: TimeInterval(0.008 * distance))
                let removeblockss = SKAction.removeFromParent()
                moveAndRemove = SKAction.sequence([moveblockss, removeblockss])
                
                turtle.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                turtle.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
            }
            
        } else if levelChange {
            if !levelTransition {
                levelChange = false
                self.turtle.run(repeatActionTurtle)
                self.turtle.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                self.turtle.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
            }
        } else {
            if isDied == false {
                turtle.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                turtle.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if !levelChange {
            if isGameStarted == true{
                if isDied == false{
                    enumerateChildNodes(withName: "background", using: ({
                        (node, error) in
                        let bg = node as! SKSpriteNode
                        bg.texture = SKTexture(imageNamed: "level\(self.level)")
                        bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                        if bg.position.x <= -bg.size.width {
                            bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y:bg.position.y)
                        }
                    }))
                }
            }
        } else if levelChange {
            self.wallPair.removeFromParent()
        }
    }
    
    func createScene(){
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = CollisionBitMask.groundCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.turtleCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.turtleCategory
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        for i in 0..<2
        {
            if level > 11 {
                let backgroundNumber = Int.random(in: 1 ... 10)
                background = SKSpriteNode(imageNamed: "level\(backgroundNumber)")
            } else {
                background = SKSpriteNode(imageNamed: "level\(level)")
            }
            
            background.anchorPoint = CGPoint.init(x: 0, y: 0)
            background.position = CGPoint(x:CGFloat(i) * self.frame.width, y:0)
            background.name = "background"
            background.size = (self.view?.bounds.size)!
            self.addChild(background)
        }
        
        //SET UP THE TURTLE SPRITES FOR ANIMATION
        turtleSprites.append(turtleAtlas.textureNamed("turtle1"))
        turtleSprites.append(turtleAtlas.textureNamed("turtle2"))
        turtleSprites.append(turtleAtlas.textureNamed("turtle3"))
        turtleSprites.append(turtleAtlas.textureNamed("turtle4"))
        
        self.turtle = createTurtle()
        if levelChange {
            self.physicsBody = nil
            self.turtle.position.x = self.frame.midX - 300
        }
        
        self.addChild(turtle)
        addSmokeToFloyd()
        
        //PREPARE TO ANIMATE THE TURTLE AND REPEAT THE ANIMATION FOREVER
        let animateTurtle = SKAction.animate(with: self.turtleSprites as! [SKTexture], timePerFrame: 0.1)
        self.repeatActionTurtle = SKAction.repeatForever(animateTurtle)
        
        if levelChange {
            self.turtle.position.x = -100
            let moveToCenterScreen = SKAction.move(to: CGPoint(x: self.frame.midX, y: turtle.position.y), duration: 2)
            let sequence = SKAction.sequence([moveToCenterScreen])
            self.turtle.run(repeatActionTurtle)
            turtle.run(sequence) {
                self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
                self.physicsBody?.categoryBitMask = CollisionBitMask.groundCategory
                self.physicsBody?.collisionBitMask = CollisionBitMask.turtleCategory
                self.physicsBody?.contactTestBitMask = CollisionBitMask.turtleCategory
                self.physicsBody?.isDynamic = false
                self.physicsBody?.affectedByGravity = false
            }
        }
        
        uiBkg = createUiBk()
        self.addChild(uiBkg)
        
        scoreLbl = createScoreLabel()
        self.addChild(scoreLbl)
        
        highscoreLbl = createHighscoreLabel()
        self.addChild(highscoreLbl)
        
        gemsLbl = createGemsLabel()
        self.addChild(gemsLbl)
        
        levelLbl = createLevelLabel()
        self.addChild(levelLbl)
        
        createHomeButton()
        
        if !levelChange {
            
            if !isGameContinued {
                createLogo()
            }
            
            taptoplayLbl = createTaptoplayLabel()
            self.addChild(taptoplayLbl)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == CollisionBitMask.turtleCategory && secondBody.categoryBitMask == CollisionBitMask.blocksCategory || firstBody.categoryBitMask == CollisionBitMask.blocksCategory && secondBody.categoryBitMask == CollisionBitMask.turtleCategory || firstBody.categoryBitMask == CollisionBitMask.turtleCategory && secondBody.categoryBitMask == CollisionBitMask.groundCategory || firstBody.categoryBitMask == CollisionBitMask.groundCategory && secondBody.categoryBitMask == CollisionBitMask.turtleCategory{
            enumerateChildNodes(withName: "wallPair", using: ({
                (node, error) in
                node.speed = 0
                self.removeAllActions()
            }))
            if isDied == false{
                isDied = true
                if soundOn == 1 {
                    run(fallingSound)
                }
                let hscore = iCloudDefaults.object(forKey: "highScore") as! Int
                if hscore < Int(scoreLbl.text!)!{
                    saveScoreToCloud()
                    saveHighscore(gameScore: Int(scoreLbl.text!)!)
                }
                createRestartBtn()
                createContinueBtn()
                self.turtle.removeAllActions()
                if !FlappyProducts.store.isProductPurchased("PREMIUMFLOYD2019") {
                    if (self.interstitial.isReady) {
                        self.interstitial.present(fromRootViewController: (self.view?.window!.rootViewController)!)
                    }
                }
            }
        } else if firstBody.categoryBitMask == CollisionBitMask.turtleCategory && secondBody.categoryBitMask == CollisionBitMask.gemCategory {
            if soundOn == 1 {
                run(impactSound)
            }
            score += 1
            levelGoal += 1
            if levelGoal == 23 + (level * 2) {
                levelChange = true
                changeLevel()
            }
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
        } else if firstBody.categoryBitMask == CollisionBitMask.gemCategory && secondBody.categoryBitMask == CollisionBitMask.turtleCategory {
            if soundOn == 1 {
                run(impactSound)
            }
            score += 1
            levelGoal += 1
            if levelGoal == 23 + (level * 2) {
                levelChange = true
                changeLevel()
            }
            scoreLbl.text = "\(score)"
            firstBody.node?.removeFromParent()
        }
    }
    
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        isDied = false
        isGameStarted = false
        if !isGameContinued {
            score = 0
        }
        createScene()
    }
    
    func addSmokeToFloyd(){
        sparkEmmiter = SKEmitterNode(fileNamed: "smoketrail")!
        sparkEmmiter.position = CGPoint(x: -55, y: 14)
        sparkEmmiter.name = "smoketrail"
        sparkEmmiter.zPosition = 22.0
        sparkEmmiter.targetNode = self.scene
        turtle.addChild(self.sparkEmmiter)
    }
    
    func addrocketFire(){
        sparkEmmiter = SKEmitterNode(fileNamed: "rocketfire")!
        sparkEmmiter.position = CGPoint(x: -45, y: 14)
        sparkEmmiter.name = "rocketfire"
        sparkEmmiter.zPosition = 23.0
        sparkEmmiter.targetNode = self.scene
        
        let addEmitterAction = SKAction.run({self.turtle.addChild(self.sparkEmmiter)})
        let wait = SKAction.wait(forDuration: 5.0)
        let remove = SKAction.run({self.sparkEmmiter.removeFromParent()})
        
        let sequence = SKAction.sequence([addEmitterAction, wait, remove])
        self.run(sequence)        
    }
    
    func changeLevel()  {
        levelTransition = true
        self.physicsBody = nil
        self.wallPair.physicsBody = nil
        
        levelLbl.text = "Level Complete"
        levelLbl.fontName = "HelveticaNeue-Bold"
        levelLbl.fontColor = .black
        levelLbl.fontSize = 40
        levelLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        levelLbl.horizontalAlignmentMode = .center
        levelLbl.zPosition = 51
        levelLbl.alpha = 1.0
        levelLbl.run(SKAction.fadeIn(withDuration: 4))
        levelLbl.run(SKAction.fadeOut(withDuration: 4))
        
        let moveOffScreen = SKAction.move(to: CGPoint(x: 600, y: turtle.position.y), duration: 3)
        let sequence = SKAction.sequence([moveOffScreen])
        turtle.run(sequence)
        if turtle.position.x > 500 {
            self.turtle.removeFromParent()
        }
        
        saveGemsToCloud(gems: levelGoal)
        levelGoal = 0
        
        let rectangle = CGRect(origin: CGPoint(x: 0,y :0), size: self.size)
        let fader = SKSpriteNode()
        fader.position.x = self.size.width / 2
        fader.position.y = self.size.height / 2
        fader.size = rectangle.size
        fader.color = .black
        fader.alpha = 0
        fader.zPosition = 60
        self.addChild(fader)
        let wait = SKAction.wait(forDuration: 3)
        let waitForSceneCreation = SKAction.wait(forDuration: 5)
        let fadeIn = SKAction.fadeIn(withDuration: 3)
        let fadeOut = SKAction.fadeOut(withDuration: 3)
        fader.run(fadeIn)
        level += 1
        fader.run(wait) {
            self.background.position = CGPoint(x:0,y:0)
            self.background.texture = SKTexture(imageNamed: "level\(self.level)")
            fader.run(fadeOut)
        }
        fader.run(waitForSceneCreation) {
            //For all children
            self.removeAllChildren()
            self.createScene()
            fader.removeFromParent()
            self.levelLbl.alpha = 1.0
            self.levelLbl.run(SKAction.fadeIn(withDuration: 2))
            self.levelLbl.text = "Level \(self.level)"
            self.levelLbl.fontColor = .black
            self.levelLbl.position.y = self.levelLbl.position.y + 85
            let delay = SKAction.wait(forDuration: 1)
            self.addChild(self.pauseLabel)
            self.pauseLabel.fontName = "HelveticaNeue-Bold"
            self.pauseLabel.fontSize = 40
            self.pauseLabel.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + 50)
            self.pauseLabel.horizontalAlignmentMode = .center
            self.pauseLabel.zPosition = 51
            self.pauseLabel.fontColor = .black
            self.pauseLabel.text = "3"
            self.pauseLabel.run(delay) {
                self.levelLbl.run(SKAction.fadeOut(withDuration: 3))
                self.pauseLabel.text = "2"
                self.pauseLabel.run(delay) {
                    
                    self.pauseLabel.text = "1"
                    self.pauseLabel.run(delay) {
                        self.pauseLabel.removeFromParent()
                        self.levelTransition = false
                        self.turtle.physicsBody?.affectedByGravity = true
                        if self.soundOn == 1 {
                            self.addChild(self.backgroundSound)
                        }
                    }
                }
            }
        }
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let newAd = GADInterstitial(adUnitID: "ca-app-pub-4197329129239705/6334512283")
        newAd.delegate = self
        newAd.load(GADRequest())
        return newAd
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    //sends the highest score to leaderboard
    func saveHighscore(gameScore: Int) {
        print ("You have a high score!")
        print("\n Attempting to authenticating with GC...")
        
        if GKLocalPlayer.local.isAuthenticated {
            print("\n Success! Sending highscore of \(score) to leaderboard")
            
            let my_leaderboard_id = "HIGHSCOREFLAPPYFLOYD2019"
            let scoreReporter = GKScore(leaderboardIdentifier: my_leaderboard_id)
            
            scoreReporter.value = Int64(gameScore)
            let scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.report(scoreArray, withCompletionHandler: {error -> Void in
                if error != nil {
                    print("An error has occured:")
                    print("\n \(String(describing: error)) \n")
                }
            })
        }
    }
    func isKeyPresentInCloud(key: String) -> Bool {
        return iCloudDefaults.object(forKey: key) != nil
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
    
    func saveScoreToCloud() {
        // Highscores
        if (Int(scoreLbl.text!)! > iCloudDefaults.object(forKey: "highScore") as? Int ?? Int()) {
            iCloudDefaults.set(Int(scoreLbl.text!)!, forKey: "highScore")
            iCloudDefaults.synchronize()
        }
        
    }
    
    func saveGemsToCloud(gems: Int) {
        let currentGems = iCloudDefaults.object(forKey: "gems") as! Int
        iCloudDefaults.set(currentGems + gems, forKey: "gems")
        iCloudDefaults.synchronize()
        
    }
    
}
