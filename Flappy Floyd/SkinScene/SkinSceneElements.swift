//
//  SkinSceneElements.swift
//  Flappy Floyd
//
//  Created by Dustin Moore on 11/1/19.
//  Copyright © 2019 Dustin Moore. All rights reserved.
//

import SpriteKit

extension SkinScene {
    struct screen {
        static let width = UIScreen.main.bounds.size.width
        static let height = UIScreen.main.bounds.size.height
        static let widthRatio = UIScreen.main.bounds.size.width / 320
        static let heightRatio = (UIScreen.main.bounds.size.height == 480) ?1 :(UIScreen.main.bounds.size.height / 568)
        static let maxLength = max(screen.width, screen.height)
        static let minLength = min(screen.width, screen.height)
    }
}
