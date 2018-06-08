//
//  OrderManager.swift
//  CoffeeExample
//
//  Created by Sofiane Beors on 08/06/2018.
//  Copyright © 2018 S-BEORS. All rights reserved.
//

import Foundation

public class OrderManager {
    public static var orders: [OrderCoffeeIntent] = []
    public enum coffeeType: String {
        case expresso = "Expresso"
        case cappucino = "Cappucino"
        case macciato = "Macciato"
    }

    public class func makeOrder(intent: OrderCoffeeIntent) {
        self.orders.append(intent)
    }
}
