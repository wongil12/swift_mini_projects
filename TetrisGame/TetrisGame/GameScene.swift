//
//  GameScene.swift
//  TetrisGame
//
//  Created by Wongil on 2022/03/29.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        Variables.scene = self
        
        let bg = BackGround()
        let generator = BrickGenerator()
    }
}
