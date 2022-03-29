//
//  Background.swift
//  TetrisGame
//
//  Created by Wongil on 2022/03/29.
//

import Foundation
import SpriteKit

class BackGround {
    
    let row = 10
    let col = 20
    let brickSize = Variables.brickValue.brickSize
    let gab = Variables.gab
    let scene = Variables.scene
    
    init() {
        Variables.backarrays = Array(repeating: Array(repeating: 0, count: row), count: col)
        let xValue = ((Int(scene.frame.width) - row * brickSize) + brickSize) / 2
        
        Variables.startPoint = CGPoint(x: xValue, y: 100)
        bg()
    }
    
    func bg() {
        for i in 0..<row {
            Variables.backarrays[col - 1][i] = 1
            Variables.scene.addChild(wall(x: i, y: col - 1))
        }
        for i in 0..<col-1 {
            Variables.backarrays[i][0] = 1
            Variables.scene.addChild(wall(x: 0, y: i))
        }
        for i in 0..<col-1 {
            Variables.backarrays[i][row-1] = 1
            Variables.scene.addChild(wall(x: row - 1, y: i))
        }
        for i in 0..<row {
            Variables.backarrays[0][i] = 1
            Variables.scene.addChild(wall(x: i, y: 0))
        }
    }
    
    func wall(x: Int, y: Int) -> SKSpriteNode {
        let brick = SKSpriteNode()
        brick.size = CGSize(width: brickSize - gab, height: brickSize - gab)
        brick.color = .blue
        brick.name = "wall"
        brick.zPosition =  1
        let xValue = x * brickSize + Int(Variables.startPoint.x)
        let yValue = y * brickSize + Int(Variables.startPoint.y)
        brick.position = CGPoint(x: xValue, y: -yValue)
        
        return brick
    }
}
