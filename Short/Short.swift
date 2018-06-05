//
//  Short.swift
//  Short
//
//  Created by Sofiane Beors on 05/06/2018.
//  Copyright © 2018 S-BEORS. All rights reserved.
//

import Foundation
import IntentsUI
import Intents

public class Short {
    private static var voiceShortcuts: [INVoiceShortcut] = []
    
    public class func getAllVoiceShortcuts(completion: @escaping (([INVoiceShortcut]?) -> Void)) {
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { (voiceShortcut, error) in
            if let voiceShortcut = voiceShortcut {
                if error == nil {
                    completion(voiceShortcut)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    public class func getVoiceShortcutFrom(intent: INIntent, completion: @escaping ((INVoiceShortcut)?) -> Void) {
        INVoiceShortcutCenter.shared.getVoiceShortcut(with: UUID(uuidString: intent.identifier!)!) { (voiceShortcut, error) in
            if let voiceShortcut = voiceShortcut {
                if error == nil {
                    completion(voiceShortcut)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    public class func getShortcutFrom(intent: INIntent) -> INShortcut? {
        let shortcut = INShortcut(intent: intent)
        if shortcut != nil {
            return shortcut
        } else {
            return nil
        }
    }
    
    public class func presentSiriShortcutViewController(from: UIViewController, shortcut: INShortcut) {
        let addVoiceShortcutVC = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        addVoiceShortcutVC.delegate = from as? INUIAddVoiceShortcutViewControllerDelegate
        from.present(addVoiceShortcutVC, animated: true)
    }
    
    public class func presentExistingSiriShortcutViewController(from: UIViewController, voiceShortcut: INVoiceShortcut) {
        let editVoiceShortcutViewController = INUIEditVoiceShortcutViewController(voiceShortcut: voiceShortcut)
        editVoiceShortcutViewController.delegate = from as? INUIEditVoiceShortcutViewControllerDelegate
        from.present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    public class func donateInteraction(for intent: INIntent) {
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.donate { (error) in
            if error != nil {
                print("Interaction donation failed")
            } else {
                print("Successfully donated interaction")
            }
        }
    }
}
