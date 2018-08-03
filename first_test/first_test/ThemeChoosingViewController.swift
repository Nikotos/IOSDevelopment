//
//  ThemeChoosingViewController.swift
//  first_test
//
//  Created by NIKITOS on 12.07.2018.
//  Copyright © 2018 NIKITOS. All rights reserved.
//

import UIKit

class ThemeChoosingViewController: UIViewController {


    let themes = [
        "Sports" : ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐"],
        "Animals": ["🐕","🐓","🐿","🦔","🐘", "🐒"],
        "Faces" : ["🤪", "😇", "🤔", "😆", "😛", "😍"]
    ]


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
        }
    }


}
