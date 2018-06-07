//
//  ViewController.swift
//  Example
//
//  Created by Sofiane Beors on 05/06/2018.
//  Copyright © 2018 S-BEORS. All rights reserved.
//

import UIKit
import Short
import IntentsUI

class ViewController: UIViewController {

    let orderIntent = OrderCoffeeIntent()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addToSiriDidTapped(_ sender: Any) {
        self.orderIntent.coffee = "Expresso"
        self.orderIntent.quantity = 1
        
        Order(from: self.orderIntent)
        Short.donateInteraction(for: self.orderIntent)
        
        let shortcut = Short.getShortcutFrom(intent: self.orderIntent)
        if let shortcut = shortcut {
            Short.presentSiriShortcutViewController(from: self, shortcut: shortcut)
        }
    }
}


extension ViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        // add shortcut
        dismiss(animated: true)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        dismiss(animated: true)
    }
}

extension ViewController: INUIEditVoiceShortcutViewControllerDelegate {
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        // update shortcut
        dismiss(animated: true)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        // delete shortcut
        dismiss(animated: true)
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        dismiss(animated: true)
    }
}
