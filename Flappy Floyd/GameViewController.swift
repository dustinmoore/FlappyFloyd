//
//  GameViewController.swift
//  Flappy Floyd
//
//  Created by Dustin Moore on 10/25/19.
//  Copyright © 2019 Dustin Moore. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController {
    
    func authenticateLocalPlayer() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = {(viewController, error) -> Void in

            if (viewController != nil) {
                self.present(viewController!, animated: true, completion: nil)
            }
            else {
                print((GKLocalPlayer.local.isAuthenticated))
            }
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // AUTHENTICATION
        authenticateLocalPlayer()
        
        let scene = MenuScene(fileNamed:"MenuScene")
        let skView = view as! SKView
        //skView.showsFPS = true
        //skView.showsNodeCount = true
        skView.ignoresSiblingOrder = false
        //print (view.bounds.size)
        //scene?.size = CGSize(width: 414, height: 896)
        scene?.scaleMode = .fill
        skView.presentScene(scene)
        
    }
 
   override var shouldAutorotate: Bool {
        return false
    }
 
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
 
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
