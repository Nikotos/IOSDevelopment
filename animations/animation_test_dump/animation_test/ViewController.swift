//
//  ViewController.swift
//  animation_test
//
//  Created by NIKITOS on 13.07.2018.
//  Copyright © 2018 NIKITOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cardViews: [PlayingCardView]!
    
    private var deck = PlayingCardDeck()

    override func viewDidLoad() {
        super.viewDidLoad()
        var cards = [PlayingCard]()
        for _ in 1...((cardViews.count + 1) / 2) {
            let card = deck.giveCard()!
            cards += [card, card]
        }
        for cardView in cardViews {
            cardView.isFaceUp = true
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
        }
    }
    
    @objc func flipCard(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let choosenCardView = recognizer.view as? PlayingCardView {
                choosenCardView.isFaceUp = !choosenCardView.isFaceUp
            }
        default:
            break
        }
        
    }
 

}

