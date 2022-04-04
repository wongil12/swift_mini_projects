//
//  DownButton.swift
//  TetrisGame
//
//  Created by Wongil on 2022/04/04.
//

import Foundation
import SpriteKit

class DownButton {
    let btn = SKSpriteNode()
    
    init() {
        btn.texture = SKTexture(imageNamed: "down_btn1")
        btn.size = CGSize(width: 50, height: 50)
        btn.name = "down"
        btn.zPosition = 1
        let point1 = Int(Variables.scene.frame.width) / 2
        let point2 = -50
        let xValue = (point1 - point2) / 2
        btn.position = CGPoint(x: xValue, y: -Int(Variables.scene.frame.height) + 50)
        Variables.scene.addChild(btn)
    }
    
    
    func anim() {
        var textures = [SKTexture]()
        for i in 1...15 {
            let name = "down_btn\(i)"
            let texture = SKTexture(imageNamed: name)
            textures.append(texture)
        }
        
        let action = SKAction.animate(with: textures, timePerFrame: 0.03)
        btn.run(action)
    }
    
    func brickDown() {
        if isBrickDownable() {
            possibleDown()
        } else {
            imPossibleDown()
        }
    }
    
    // 블럭이 아래로 내려갈 수 있을 경우
    func possibleDown() {
        Variables.dy += 1
        var action = SKAction()
        for (i, item) in Variables.brickArrays.enumerated() {
            let x = Int(item.x) + Variables.dx
            let y = Int(item.y) + Variables.dy
            
            Variables.backarrays[y - 1][x] -= 1
            Variables.backarrays[y][x] += 1
            action = SKAction.moveBy(x: 0, y: -CGFloat(Variables.brickValue.brickSize), duration: 0.1)
            Variables.brickNode[i].run(action)
        }
    }
    
    // 블럭이 아래로 내려갈 수 없을 경우
    func imPossibleDown() {
        // 값을 2로 변경
        for item in Variables.brickArrays {
            let x = Int(item.x) + Variables.dx
            let y = Int(item.y) + Variables.dy
            
            Variables.backarrays[y][x] = 2
            // 새로운 블럭 생성
            let blocked = SKSpriteNode()
            blocked.color = .gray
            blocked.size = CGSize(width: Variables.brickValue.brickSize - Variables.gab, height: Variables.brickValue.brickSize - Variables.gab)
            blocked.name = "blocked"
            let xValue = x * Variables.brickValue.brickSize + Int(Variables.startPoint.x)
            let yValue = y * Variables.brickValue.brickSize + Int(Variables.startPoint.y)
            blocked.position = CGPoint(x: xValue, y: -yValue)
            Variables.scene.addChild(blocked)
            Variables.blockedArrays.append(blocked)
        }
        
        // 기존 블럭 삭제
        for item in Variables.brickNode {
            item.removeFromParent()
        }
        
        checkDelete()
    }
    
    func checkDelete() {
        // 블럭에서 중복된 y제거
        var set = Set<Int>()
        for item in Variables.brickArrays {
            let y = Int(item.y) + Variables.dy
            set.insert(y)
        }
        
        
        _ = BrickGenerator()
    }
    
    func isBrickDownable() -> Bool {
        
        for item in Variables.brickArrays {
            let x = Int(item.x) + Variables.dx
            let y = Int(item.y) + Variables.dy
            if Variables.backarrays[y + 1][x] == 2 {
                return false
            }
        }
        return true
    }
}
