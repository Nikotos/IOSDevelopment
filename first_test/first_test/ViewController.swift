//
//  ViewController.swift
//  first_test
//
//  Created by NIKITOS on 27.06.2018.
//  Copyright © 2018 NIKITOS. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    @IBOutlet var cardViews: [PlayingCardView]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    var cardsFaces = [String]()
    
    lazy var game = Concentration(withUniqueCards: cardViews.count / 2)
    
    var theme: [String]? {
        didSet {
            cardsFaces = theme ?? []
        }
    }

    private var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //print("count - \(cardViews.count)")
            for index in cardViews.indices {
                var backEndCard = game.cards[index]
                let frontEndCard = cardViews[index]
                frontEndCard.imageString = makePictureForCard(with: backEndCard.identifier)
                frontEndCard.isFaceUp = false
                backEndCard.isFaceUp = false
                frontEndCard.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                    action: #selector(flipCard(_:))))
                updateViewFromModel()
        }
    }
    
    private var faceCardsDictionary = [Int: String]()
    private func makePictureForCard(with identifier: Int) -> String {
        if let picture = faceCardsDictionary[identifier] {
            return picture
        } else if !cardsFaces.isEmpty {
            faceCardsDictionary[identifier] = cardsFaces.remove(at: cardsFaces.count.arc4random)
            return faceCardsDictionary[identifier]!
        } else {
            return "?"
        }
    }

    @objc func flipCard(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let choosenCard = recognizer.view as? PlayingCardView {
                if let cardIndex = cardViews.index(of: choosenCard) {
                    flipCount += 1
                    game.handleCardTouch(index: cardIndex)
                    updateViewFromModel()
                }
            }
        default:
            break
        }
    }
    
    @IBAction func startNewGame() {
        print("new game")
        flipCount = 0
        game.restart()
        restartView()
    }

    private func restartView() {
        for cardIndex in cardViews.indices {
            let backEndCard = game.cards[cardIndex]
            let frontEndCard = cardViews[cardIndex]
            frontEndCard.appearToTable()
            frontEndCard.imageString = makePictureForCard(with: backEndCard.identifier)
        }
    }
    
    
    private func updateViewFromModel() {
        for cardIndex in cardViews.indices {
            let backEndCard = game.cards[cardIndex]
            let frontEndCard = cardViews[cardIndex]
            
            if frontEndCard.isFaceUp != backEndCard.isFaceUp, !frontEndCard.isOutOfGame {
                UIView.transition(
                    with: frontEndCard,
                    duration: cardTurningDuration,
                    options: [.transitionFlipFromLeft],
                    animations: { frontEndCard.isFaceUp = backEndCard.isFaceUp } )
            }
            if backEndCard.isOutOfGame, !frontEndCard.isOutOfGame {
                UIViewPropertyAnimator.runningPropertyAnimator(
                    withDuration: cardDisappearingDuration,
                    delay: 1,
                    options: [],
                    animations: { frontEndCard.disappeareFromTable() })
            }
        }
    }
}



extension ConcentrationViewController {
    private struct AnimationRatio {
        static let cardTurningDuration = 0.5
        static let cardDisappearingDuration = 0.9
    }
    
    private var cardTurningDuration: Double {
        return AnimationRatio.cardTurningDuration
    }
    private var cardDisappearingDuration: Double {
        return AnimationRatio.cardDisappearingDuration
    }
}


