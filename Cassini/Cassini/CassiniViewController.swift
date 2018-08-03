//
//  CassiniViewController.swift
//  Cassini
//
//  Created by NIKITOS on 16.07.2018.
//  Copyright © 2018 NIKITOS. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {


    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController
        ) -> Bool {
        if let ivc = secondaryViewController as? ImageViewController {
            if ivc.imageURL == nil {
                return false
            }
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if let url = URLHolder.NASA[identifier] {
                if let ImageVC = segue.destination.contents as? ImageViewController {
                    ImageVC.imageURL = url
                    ImageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }
 

}


extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        }
        else {
            return self
        }
    }
}
