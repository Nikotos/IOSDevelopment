//
//  Concentration.swift
//  first_test
//
//  Created by NIKITOS on 03.07.2018.
//  Copyright © 2018 NIKITOS. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()

    private var flippedCardsIndices = [Int]()
    
    init(withUniqueCards amount: Int) {
        for _ in 1...amount {
            let card = Card.init()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    
    func handleCardTouch(index: Int) {
        var tempCardIndex: Int
        if !cards[index].isOutOfGame {
            if flippedCardsIndices.isEmpty {
                cards[index].isFaceUp = true
                flippedCardsIndices.append(index)
            } else if flippedCardsIndices.count == 2 {
                tempCardIndex = flippedCardsIndices.popLast()!
                cards[tempCardIndex].isFaceUp = false
                tempCardIndex = flippedCardsIndices.popLast()!
                cards[tempCardIndex].isFaceUp = false
                
                cards[index].isFaceUp = true
                flippedCardsIndices.append(index)
            } else if !cards[index].isFaceUp {
                cards[index].isFaceUp = true
                flippedCardsIndices.append(index)
                tempCardIndex = flippedCardsIndices[0]
                if tempCardIndex != index, cards[tempCardIndex].identifier == cards[index].identifier {
                    cards[tempCardIndex].isOutOfGame = true
                    cards[index].isOutOfGame = true
                }
            }
        }
        
    }
    
    func restart() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isOutOfGame = false
        }
        cards.shuffle()
        flippedCardsIndices = []
    }
    
}
