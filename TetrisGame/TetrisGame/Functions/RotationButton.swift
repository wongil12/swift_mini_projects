//
//  RotationButton.swift
//  TetrisGame
//
//  Created by Wongil on 2022/04/03.
//

import Foundation
import SpriteKit

class RotationButton {
    let btn = SKSpriteNode()
    
    init() {
        btn.texture = SKTexture(imageNamed: "rotaion_btn1")
        btn.size = CGSize(width: 50, height: 50)
        btn.name = "rotation"
        btn.position = CGPoint(x: Int(Variables.scene.frame.width) / 2, y: -Int(Variables.scene.frame.height) + 50)
        Variables.scene.addChild(btn)
    }
    
    
}
