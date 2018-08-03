//
//  DopeTech.swift
//  set_game
//
//  Created by NIKITOS on 06.07.2018.
//  Copyright © 2018 NIKITOS. All rights reserved.
//

import Foundation


protocol AllCaseable {
    static var allCases:  [Self] { get }
}



extension MutableCollection {
    mutating func shuffle() {
        let c = self.count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}
