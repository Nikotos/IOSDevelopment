//
//  Card.swift
//  set_game
//
//  Created by NIKITOS on 06.07.2018.
//  Copyright © 2018 NIKITOS. All rights reserved.
//

import Foundation

struct Card {
    
    var isOnTable = false
    var isSelected = false
    
    //TODO make an array with attributes
    
    var shape: CardShape
    var color: CardColor
    var amount: CardSymbolsAmount
    var texture: CardTexture

    init(shape: CardShape, color: CardColor,
         amount: CardSymbolsAmount, texture: CardTexture) {
        self.shape = shape
        self.color = color
        self.amount = amount
        self.texture = texture
    }
    
}

//TODO upgrade it to superclass logic

enum CardShape: AllCaseable {
    case triangle, square, circle
    
    static var allCases: [CardShape] {
        return [.triangle, .square, .circle]
    }
}

enum CardColor:  AllCaseable  {
    case red, green, blue
    
    static var allCases: [CardColor] {
        return [.red, .green, .blue]
    }
}

enum CardSymbolsAmount: Int, AllCaseable  {
    case one = 1, two = 2, three = 3
    
    static var allCases: [CardSymbolsAmount] {
        return [.one, .two, .three]
    }
}

enum CardTexture:  AllCaseable  {
    case filled, striped, empty
    
    static var allCases: [CardTexture] {
        return [.filled, .striped, .empty]
    }
}


