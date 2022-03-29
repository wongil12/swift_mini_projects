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
    
    init() {
        Variables.backarrays = Array(repeating: Array(repeating: 0, count: row), count: col)
    }
}
