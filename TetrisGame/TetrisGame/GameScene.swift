//
//  GameScene.swift
//  TetrisGame
//
//  Created by Wongil on 2022/03/29.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var leftButton: LeftButton?
    var rightButton: RightButton?
    var rotationButton: RotationButton?
    var downButton: DownButton?
    
    override func didMove(to view: SKView) {
        Variables.scene = self
        
        _ = BackGround()
        _ = BrickGenerator()
        
        leftButton = LeftButton()
        rightButton = RightButton()
        rotationButton = RotationButton()
        downButton = DownButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        let node = nodes(at: location!)
        for item in node {
            if item.name == "left" {
                leftButton?.brickMoveLeft()
            } else if item.name == "right" {
                rightButton?.brickMoveRight()
            } else if item.name == "rotation" {
                rotationButton?.brickRotation()
            } else if item.name == "down" {
                downButton?.brickDown()
            }
        }
    }
}
