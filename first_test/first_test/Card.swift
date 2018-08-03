//
//  Card.swift
//  first_test
//
//  Created by NIKITOS on 04.07.2018.
//  Copyright © 2018 NIKITOS. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isOutOfGame = false
    var identifier: Int
    
    private static var totalCardsAmount = 0
    
    private static func getIdentifier() -> Int {
        totalCardsAmount += 1
        return totalCardsAmount
    }
    
    init() {
        self.identifier = Card.getIdentifier()
    }
}
