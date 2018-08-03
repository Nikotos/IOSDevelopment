//
//  SetGame.swift
//  set_game
//
//  Created by NIKITOS on 06.07.2018.
//  Copyright © 2018 NIKITOS. All rights reserved.
//

import Foundation

class SetGame {
    
    var deck = [Card]()
    
    var cardsAtTable = [Card]()
    
    var selectedCardsIndicies = [Int]()
    
    var score = 0
    
    var penalty = 0

    
    init() {
        createNewDeck()
        firstTablePrepare()
    }
    
    func createNewDeck() {
        deck = []
        
        for cardShape in CardShape.allCases {
            for cardColor in CardColor.allCases {
                for cardSymbolsAmount in CardSymbolsAmount.allCases {
                    for cardTexture in CardTexture.allCases {
                        let card = Card(shape: cardShape, color: cardColor,
                                        amount :cardSymbolsAmount, texture: cardTexture)
                        deck.append(card)
                    }
                }
            }
        }
        
       deck.shuffle()
    }
    
    func firstTablePrepare() {
        for _ in 1...12 {
            var card = deck.popLast()!
            card.isOnTable = true
            cardsAtTable.append(card)
        }
    }
    
    func handleCardTouch(index: Int) {
        if selectedCardsIndicies.count <= 2 {
            selectedCardsIndicies.append(index)
            cardsAtTable[index].isSelected = true
        } else {
            for _ in 0...2 {
                if let cardIndex = selectedCardsIndicies.popLast() {
                    cardsAtTable[cardIndex].isSelected = false
                }
            }
            selectedCardsIndicies.append(index)
            cardsAtTable[index].isSelected = true
        }
    }
    
    func checkChoosenCards() {
        if isMatch(threeCardsIndicies: selectedCardsIndicies) {
            score += 5
            if deck.count >= 3 {
                for index in selectedCardsIndicies {
                    cardsAtTable[index] = deck.popLast()!
                }
            } else {
                for index in selectedCardsIndicies {
                    cardsAtTable[index].isOnTable = false
                }
            }
        } else {
            penalty += 10
        }
    }
    
    func addThreeMoreCardsToTable() {
        guard deck.count >= 3 else {return}
        for _ in 1...3 {
            var card = deck.popLast()!
            card.isOnTable = true
            cardsAtTable.append(card)
        }
    }
    
    
    func isMatch(threeCardsIndicies: [Int]) -> Bool {
        var flag = true
        let card1 = cardsAtTable[threeCardsIndicies[0]]
        let card2 = cardsAtTable[threeCardsIndicies[1]]
        let card3 = cardsAtTable[threeCardsIndicies[2]]
        var condition: Bool
        
        condition = ((card1.shape == card2.shape) && (card2.shape == card3.shape)) ||
            ((card1.shape != card2.shape) && (card2.shape != card3.shape) && (card1.shape != card3.shape))
        flag = flag && condition
        
        condition = ((card1.color == card2.color) && (card2.color == card3.color)) ||
            ((card1.color != card2.color) && (card2.color != card3.color) && (card1.color != card3.color))
        flag = flag && condition
        
        condition = ((card1.amount == card2.amount) && (card2.amount == card3.amount)) ||
            ((card1.amount != card2.amount) && (card2.amount != card3.amount) && (card1.amount != card3.amount))
        flag = flag && condition
        
        condition = ((card1.texture == card2.texture) && (card2.texture == card3.texture)) ||
            ((card1.texture != card2.texture) && (card2.texture != card3.texture) && (card1.texture != card3.texture))
        flag = flag && condition
      
        
        return flag
    }
    
    
}
