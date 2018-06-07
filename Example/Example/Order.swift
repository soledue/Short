//
//  Order.swift
//  Test
//
//  Created by Sofiane Beors on 05/06/2018.
//  Copyright © 2018 S-BEORS. All rights reserved.
//

import Foundation

class Order {
    public var quantity: Int
    public var extra: String?
    public var identifier: UUID
    public var coffee: String
    
    public var intent: OrderCoffeeIntent {
        let orderCoffeeIntent = OrderCoffeeIntent()
        orderCoffeeIntent.quantity = quantity as NSNumber
        orderCoffeeIntent.coffee = coffee
        return orderCoffeeIntent
    }
    
    init (from intent: OrderCoffeeIntent) {
        self.quantity = intent.quantity as! Int
        self.coffee = intent.coffee!
        self.identifier = UUID(uuidString: intent.identifier!)!
    }
}
