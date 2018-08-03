//
//  ViewController.swift
//  set_game
//
//  Created by NIKITOS on 06.07.2018.
//  Copyright © 2018 NIKITOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var penaltyLabel: UILabel!
    
    @IBOutlet weak var setsLabel: UILabel!
    
    lazy var game = SetGame()
    
    @IBAction func cardTouch(_ sender: UIButton) {
        if let buttonNumber = cardButtons.index(of: sender),
        buttonNumber < game.cardsAtTable.count {
            game.handleCardTouch(index: buttonNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func giveThreeMoreCards() {
        game.addThreeMoreCardsToTable()
        updateViewFromModel()
    }
    
    @IBAction func checkSelectedCards() {
        game.checkChoosenCards()
        updateViewFromModel()
    }
    
    
    func updateViewFromModel() {
        penaltyLabel.text = "Penalty: \(game.penalty)"
        setsLabel.text = "Sets: \(game.score)"
        let activeCardsAmount = game.cardsAtTable.count
        
        for index in cardButtons.indices {
            if index < activeCardsAmount {
                let button = cardButtons[index]
                let card = game.cardsAtTable[index]

                button.setTitle(composeCardTitle(card: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                if card.isSelected {
                    displayCardSelection(at: index)
                } else {
                    clearCardSelection(at: index)
                }
                
            } else {
                let button = cardButtons[index]
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.6441084743, green: 0.549726069, blue: 1, alpha: 0)
            }
        }
    }
    
    func displayCardSelection(at index: Int) {
        cardButtons[index].layer.borderWidth = 3.0
        cardButtons[index].layer.borderColor = UIColor.blue.cgColor
    }
    
    func clearCardSelection(at index: Int) {
        cardButtons[index].layer.borderWidth = 0
    }
    
    func composeCardTitle(card: Card) -> String {
        return "?"
       
    }
}









