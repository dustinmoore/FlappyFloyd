//
//  GameElements.swift
//  Flappy Floyd
//
//  Created by Dustin Moore on 10/25/19.
//  Copyright © 2019 Dustin Moore. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    static let turtleCategory:UInt32 = 0x1 << 0
    static let blocksCategory:UInt32 = 0x1 << 1
    static let gemCategory:UInt32 = 0x1 << 2
    static let groundCategory:UInt32 = 0x1 << 3
}

extension GameScene {
    func createBuyThousandGemsButton() -> SKSpriteNode {
        let thousandGemsButton = SKSpriteNode(imageNamed: "test")
        return thousandGemsButton
    }
    
    func createTurtle() -> SKSpriteNode {
        let turtle = SKSpriteNode(texture: SKTextureAtlas(named:"skin\(activeSkin)").textureNamed("turtle1"))
        turtle.size = CGSize(width: 60, height: 60)
        turtle.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        turtle.zPosition = 25

        turtle.physicsBody = SKPhysicsBody(circleOfRadius: turtle.size.width / 2)
        turtle.physicsBody?.linearDamping = 1.1
        turtle.physicsBody?.restitution = 0

        turtle.physicsBody?.categoryBitMask = CollisionBitMask.turtleCategory
        turtle.physicsBody?.collisionBitMask = CollisionBitMask.blocksCategory | CollisionBitMask.groundCategory
        turtle.physicsBody?.contactTestBitMask = CollisionBitMask.blocksCategory | CollisionBitMask.gemCategory | CollisionBitMask.groundCategory

        turtle.physicsBody?.affectedByGravity = false
        turtle.physicsBody?.isDynamic = true
        turtle.name = "turtle"
        
        return turtle
    }
    
    func createUiBk() -> SKSpriteNode  {
        let uiBkg = SKSpriteNode(imageNamed: "new-top-ui")
        uiBkg.setScale(0.55)
        uiBkg.zPosition = 3
        uiBkg.position = CGPoint(x: self.frame.width / 2, y: self.frame.maxY - 56)
        
        return uiBkg
    }
    
    func createHomeButton() {
        homeBtn = SKSpriteNode(imageNamed: "mini-home")
        homeBtn.size = CGSize(width:50, height:50)
        homeBtn.position = CGPoint(x: self.frame.minX + 50, y: self.frame.minY + 50)
        homeBtn.zPosition = 6
        homeBtn.setScale(0)
        homeBtn.name = "homeBtn"
        self.addChild(homeBtn)
        homeBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
    }

    func createRestartBtn() {
        restartBtn = SKSpriteNode(imageNamed: "restart")
        restartBtn.size = CGSize(width:100, height:100)
        restartBtn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        restartBtn.zPosition = 6
        restartBtn.setScale(0)
        restartBtn.name = "restart"
        self.addChild(restartBtn)
        restartBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    
    func createContinueBtn() {
        continueBtn = SKSpriteNode(imageNamed: "continue")
        continueBtn.setScale(0)
        continueBtn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 - 100)
        continueBtn.zPosition = 10
        continueBtn.name = "continue"
        self.addChild(continueBtn)
        continueBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    
    func createLevelLabel() -> SKLabelNode {
        let levelLbl = SKLabelNode()
        levelLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        levelLbl.text = "\(score)"
        levelLbl.zPosition = 5
        levelLbl.fontSize = 48
        levelLbl.fontName = "HelveticaNeue-Bold"
        levelLbl.alpha = 0
        
        return levelLbl
    }

    func createScoreLabel() -> SKLabelNode {
        let scoreLbl = SKLabelNode()
        if screen.width >= 1024 {
            scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height - 62 )
        } else {
            scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height - 70)
        }
        scoreLbl.text = "\(score)"
        scoreLbl.zPosition = 5
        scoreLbl.fontName = "HelveticaNeue-Bold"
        scoreLbl.fontSize = 30
                
        return scoreLbl
    }

    func createHighscoreLabel() -> SKLabelNode {
        let highscoreLbl = SKLabelNode()
        if screen.width >= 1024 {
            highscoreLbl.position = CGPoint(x: self.frame.width - 240, y: self.frame.height - 62)
        } else {
            highscoreLbl.position = CGPoint(x: self.frame.width - 80, y: self.frame.height - 50)
        }
        if let highestScore = iCloudDefaults.object(forKey: "highScore"){
            highscoreLbl.text = "\(highestScore)"
        } else {
            highscoreLbl.text = "0"
        }
        highscoreLbl.zPosition = 5
        highscoreLbl.fontSize = 15
        highscoreLbl.fontName = "Helvetica-Bold"
        return highscoreLbl
    }
    
    func createGemsLabel() -> SKLabelNode {
        let gemsLbl = SKLabelNode()
        if screen.width >= 1024 {
            gemsLbl.position = CGPoint(x: self.frame.minX + 240, y: self.frame.height - 62)
        } else {
            gemsLbl.position = CGPoint(x: self.frame.minX + 80, y: self.frame.height - 50)
        }
        if let gems = iCloudDefaults.object(forKey: "gems"){
            gemsLbl.text = "\(gems)"
        } else {
            gemsLbl.text = "0"
        }
        gemsLbl.zPosition = 5
        gemsLbl.fontSize = 15
        gemsLbl.fontName = "Helvetica-Bold"
        return gemsLbl
    }
    
    func createLogo() {
        logoImg = SKSpriteNode()
        logoImg = SKSpriteNode(imageNamed: "logo")
        logoImg.size = CGSize(width: 272, height: 65)
        logoImg.position = CGPoint(x:self.frame.midX, y:self.frame.midY + 100)
        logoImg.setScale(0.5)
        self.addChild(logoImg)
        logoImg.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    
    func createTaptoplayLabel() -> SKLabelNode {
        let taptoplayLbl = SKLabelNode()
        taptoplayLbl.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 100)
        taptoplayLbl.text = "Tap to start flappin'"
        taptoplayLbl.fontColor = UIColor(red: 63/255, green: 79/255, blue: 145/255, alpha: 1.0)
        taptoplayLbl.zPosition = 5
        taptoplayLbl.fontSize = 20
        taptoplayLbl.fontName = "HelveticaNeue"
        return taptoplayLbl
    }
    
    func createWalls() -> SKNode  {
        
        let gemNode = SKSpriteNode(imageNamed: "gem")       
        gemNode.size = CGSize(width: 40, height: 38)
        gemNode.position = CGPoint(x: self.frame.width + 50, y: self.frame.height / 2)
        gemNode.physicsBody = SKPhysicsBody(rectangleOf: gemNode.size)
        gemNode.physicsBody?.affectedByGravity = false
        gemNode.physicsBody?.isDynamic = false
        gemNode.physicsBody?.categoryBitMask = CollisionBitMask.gemCategory
        gemNode.physicsBody?.collisionBitMask = 0
        gemNode.physicsBody?.contactTestBitMask = CollisionBitMask.turtleCategory
        gemNode.color = SKColor.blue
        gemNode.name = "gem"
        
        wallPair = SKNode()
        wallPair.name = "wallPair"
        
        if level > 11 {
            blockNumber = Int.random(in: 1 ... 10)
        } else {
            blockNumber = level
        }
        
        let topWall = SKSpriteNode(imageNamed: "blocks\(blockNumber)")
        let btmWall = SKSpriteNode(imageNamed: "blocks\(blockNumber)")
        
        topWall.position = CGPoint(x: self.frame.width + 50, y: self.frame.height / 2 + 420)
        btmWall.position = CGPoint(x: self.frame.width + 50, y: self.frame.height / 2 - 420)
        
        topWall.setScale(0.5)
        btmWall.setScale(0.5)
        
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.categoryBitMask = CollisionBitMask.blocksCategory
        topWall.physicsBody?.collisionBitMask = CollisionBitMask.turtleCategory
        topWall.physicsBody?.contactTestBitMask = CollisionBitMask.turtleCategory
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.affectedByGravity = false
        
        btmWall.physicsBody = SKPhysicsBody(rectangleOf: btmWall.size)
        btmWall.physicsBody?.categoryBitMask = CollisionBitMask.blocksCategory
        btmWall.physicsBody?.collisionBitMask = CollisionBitMask.turtleCategory
        btmWall.physicsBody?.contactTestBitMask = CollisionBitMask.turtleCategory
        btmWall.physicsBody?.isDynamic = false
        btmWall.physicsBody?.affectedByGravity = false
        
        topWall.zRotation = .pi
        
        wallPair.addChild(topWall)
        wallPair.addChild(btmWall)
        
        wallPair.zPosition = 1

        let randomPosition = random(min: -175, max: 175)
        wallPair.position.y = wallPair.position.y + randomPosition
        wallPair.addChild(gemNode)
        
        wallPair.run(moveAndRemove)
        
        return wallPair
    }
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min : CGFloat, max : CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
}

struct screen {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let widthRatio = UIScreen.main.bounds.size.width / 320
    static let heightRatio = (UIScreen.main.bounds.size.height == 480) ?1 :(UIScreen.main.bounds.size.height / 568)
    static let maxLength = max(screen.width, screen.height)
    static let minLength = min(screen.width, screen.height)
}

extension SKLabelNode {
    convenience init?(fontNamed font: String, andText text: String, andSize size: CGFloat, withShadow shadow: UIColor) {
        self.init(fontNamed: font)
        self.text = text
        self.fontSize = size
        
        let shadowNode = SKLabelNode(fontNamed: font)
        shadowNode.text = self.text
        shadowNode.zPosition = self.zPosition - 1
        shadowNode.fontColor = shadow
        // Just create a little offset from the main text label
        shadowNode.position = CGPoint(x: 2, y: -2)
        shadowNode.fontSize = self.fontSize
        shadowNode.alpha = 0.5
        
        self.addChild(shadowNode)
    }
}
