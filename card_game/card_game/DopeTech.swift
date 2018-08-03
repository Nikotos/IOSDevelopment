//
//  DopeTech.swift
//  card_game
//
//  Created by NIKITOS on 10.07.2018.
//  Copyright © 2018 NIKITOS. All rights reserved.
//

import Foundation


extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
