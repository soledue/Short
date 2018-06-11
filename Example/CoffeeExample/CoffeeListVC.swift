//
//  CoffeeListVC.swift
//  CoffeeExample
//
//  Created by Sofiane Beors on 08/06/2018.
//  Copyright © 2018 S-BEORS. All rights reserved.
//

import UIKit
import Short
import IntentsUI

class CoffeeListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var siriButton: UIButton!
    let coffees = [OrderManager.coffeeType.expresso, OrderManager.coffeeType.cappucino, OrderManager.coffeeType.macciato]
    var orderCoffeeIntent = OrderCoffeeIntent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = coffees[indexPath.row].rawValue
        
        switch indexPath.row {
        case 0:
            cell.detailTextLabel?.text = "Simple Expresso"
        case 1:
            cell.detailTextLabel?.text = "Expresso with milk"
        case 2:
            cell.detailTextLabel?.text = "Expresso with chocolate and milk"
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: "Confirm", style: .default) { (action: UIAlertAction) in
            self.orderCoffeeIntent.coffeeType = coffees[indexPath.row].rawValue
            self.orderCoffeeIntent.quantity = 1 as NSNumber
            OrderManager.makeOrder(intent: self.orderCoffeeIntent)
            Short.donateInteraction(for: self.orderCoffeeIntent)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(clearAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func addToSiriDidTapped(_ sender: Any) {
        if self.orderCoffeeIntent.coffeeType == nil {
            let alertView = UIAlertController(title: "You need to make a order before", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
            alertView.addAction(cancelAction)
            self.present(alertView, animated: true, completion: nil)
        } else {
            let shortcut = Short.getShortcutFrom(intent: self.orderCoffeeIntent)
            if let shortcut = shortcut {
                Short.presentSiriShortcutViewController(from: self, shortcut: shortcut)
            }
        }
    }
}

extension CoffeeListVC: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        // add shortcut
        print("Added shortcut to siri !")
        dismiss(animated: true)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        dismiss(animated: true)
    }
}

extension CoffeeListVC: INUIEditVoiceShortcutViewControllerDelegate {
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
