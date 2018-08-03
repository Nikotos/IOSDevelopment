//
//  PlayingCardView.swift
//  first_test
//
//  Created by Oak Nick on 19.07.2018.
//  Copyright © 2018 NIKITOS. All rights reserved.
//

import UIKit

@IBDesignable
class PlayingCardView: UIView {

    @IBInspectable
    var imageString = "😀" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var isFaceUp = true { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isOutOfGame = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    private lazy var centeredLabel = createCenteredLabel()
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
        if !isFaceUp, !isOutOfGame {
            if let cardBackImage = UIImage(named: "cardBackImage")  {
                cardBackImage.draw(in: bounds)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureCenteredLabel(centeredLabel)
        centeredLabel.frame.origin = bounds.origin
            .offsetBy(dx: bounds.maxX / 2, dy: bounds.maxY / 2)
            .offsetBy(dx: -centeredLabel.frame.size.width / 2, dy: -centeredLabel.frame.size.height / 2)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    private func configureCenteredLabel(_ label: UILabel) {
        label.text = imageString
        label.font = UIFont(name: label.font.fontName, size: centeredLabelFontSize)
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.isHidden = !isFaceUp
    }
    
    
    private func createCenteredLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        addSubview(label)
        return label
    }

    func disappeareFromTable() {
        isOutOfGame = true
        alpha = 0
    }
    
    func appearToTable() {
        isHidden = false
        isOutOfGame = false
        isFaceUp = false
        alpha = 1
    }
    
}


extension PlayingCardView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImagesSizeToBounds: CGFloat = 0.75
        static let centeredLabelFontSize: CGFloat = 40
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    private var centeredLabelFontSize: CGFloat {
        return SizeRatio.centeredLabelFontSize
    }
    
}
