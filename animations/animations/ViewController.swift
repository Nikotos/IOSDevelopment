//
//  ViewController.swift
//  animations
//
//  Created by NIKITOS on 14.07.2018.
//  Copyright © 2018 NIKITOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cardViews: [PlayingCardView]!
    
    var deck = PlayingCardDeck()
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    lazy var cardBehavior = CardBehavior(in: animator)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cards = [PlayingCard]()
        for _ in 1...(cardViews.count / 2) {
            let card = deck.giveCard()!
            cards += [card, card]
        }
        for cardView in cardViews {
            cardView.isFaceUp = false
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
            
            //cardBehavior.addItem(cardView)
        }
        
    }
    
    private var faceUpCardViews: [PlayingCardView] {
        return cardViews.filter { $0.isFaceUp && !$0.isHidden && $0.transform != CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0) && $0.alpha == 1}
    }
    
    private var twofaceUpCardViewsMatch: Bool {
        return faceUpCardViews.count == 2 &&
        faceUpCardViews[0].rank == faceUpCardViews[1].rank &&
        faceUpCardViews[0].suit == faceUpCardViews[1].suit
    }
    
    
    var lastChoosenCardView: PlayingCardView?
    
    @objc func flipCard(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let choosenCardView = recognizer.view as? PlayingCardView, faceUpCardViews.count < 2 {
                lastChoosenCardView = choosenCardView
                //cardBehavior.removeItem(choosenCardView)
                UIView.transition(with: choosenCardView,
                                  duration: 0.5,
                                  options: [.transitionFlipFromLeft],
                                  animations: { choosenCardView.isFaceUp = !choosenCardView.isFaceUp },
                                  completion: {
                                    finished in
                                    let cardsToAnimate = self.faceUpCardViews
                                    if self.twofaceUpCardViewsMatch
                                    {
                                        UIViewPropertyAnimator.runningPropertyAnimator(
                                            withDuration: 0.7,
                                            delay: 0,
                                            options: [],
                                            animations: {
                                                cardsToAnimate.forEach {
                                                    $0.transform = CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
                                                }
                                                
                                            },
                                            completion: { position in
                                                UIViewPropertyAnimator.runningPropertyAnimator(
                                                    withDuration: 0.75,
                                                    delay: 0,
                                                    options: [],
                                                    animations: {
                                                        cardsToAnimate.forEach {
                                                            $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                                            $0.alpha = 0
                                                        }

                                                    },
                                                    completion: { position in
                                                        cardsToAnimate.forEach {
                                                            $0.isHidden = true
                                                            $0.alpha = 1
                                                            $0.transform = .identity
                                                        }
                                                }
                                                )
                                         }
                                        )
                                        
                                    } else if cardsToAnimate.count == 2, choosenCardView == self.lastChoosenCardView {
                                        cardsToAnimate.forEach { cardView in
                                            UIView.transition(with: cardView,
                                                              duration: 0.5,
                                                              options: [.transitionFlipFromLeft],
                                                              animations: { cardView.isFaceUp = false },
                                                              completion: { finished in
                                                                    //self.cardBehavior.addItem(cardView)
                                                              }
                                            )
                                        }
                                    } else if !choosenCardView.isFaceUp {
                                        //self.cardBehavior.addItem(choosenCardView)
                                    }
                                    
                                }
                )
                
            }
        default:
            break
        }
        
    }


}









