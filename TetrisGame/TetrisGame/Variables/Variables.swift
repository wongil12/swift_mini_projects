//
//  Variables.swift
//  TetrisGame
//
//  Created by Wongil on 2022/03/29.
//

import Foundation
import SpriteKit

struct Variables {
    static var backarrays = [[Int]]()
    static var scene = SKScene()
    static var brickValue = Brick().bricks()
    static var dx = 4
    static var dy = 2
    static let gab = 1
    static var startPoint = CGPoint()
    static var brickArrays = [CGPoint]()
    static var brickNode = [SKSpriteNode]()
    static var blockedArrays = [SKSpriteNode]()
    static var isPause = false
    static var nodeGroup  = [[SKSpriteNode]]()
    static var newBrickArray = [Brick.Bricks]()
    static let row = 13
    static let col = 25
}
