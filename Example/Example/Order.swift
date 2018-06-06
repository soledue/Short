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
    
    public enum coffeeType: String {
        case expresso = "Expresso"
        case late = "Late"
    }
    
    public enum extraType: String {
        case milk = "Milk"
        case chocolate = "Chocolate"
    }
    
    public var intent: OrderCoffeeIntent {
        let orderCoffeeIntent = OrderCoffeeIntent()
        orderCoffeeIntent.quantity = quantity as NSNumber
        switch coffeeType.RawValue() {
        case coffeeType.expresso.rawValue:
            orderCoffeeIntent.coffeeType = coffeeType.expresso.rawValue
        case coffeeType.late.rawValue:
            orderCoffeeIntent.coffeeType = coffeeType.late.rawValue
        default:
            break
        }
        
        switch extraType.RawValue() {
        case extraType.milk.rawValue:
            orderCoffeeIntent.extra = extraType.milk.rawValue
        case extraType.chocolate.rawValue:
            orderCoffeeIntent.extra = extraType.chocolate.rawValue
        default:
            break
        }
        return orderCoffeeIntent
    }
    
    init (from intent: OrderCoffeeIntent) {
        self.quantity = intent.quantity as! Int
        self.coffee = intent.coffeeType!
        if intent.extra != nil {
            self.extra = intent.extra!
            self.identifier = UUID(uuidString: intent.identifier!)!
        } else {
            self.extra = ""
            self.identifier = UUID(uuidString: intent.identifier!)!
        }
    }
}
