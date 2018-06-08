//
//  AppDelegate.swift
//  CoffeeExample
//
//  Created by Sofiane Beors on 08/06/2018.
//  Copyright © 2018 S-BEORS. All rights reserved.
//

import UIKit
import Short

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if let orderIntent = userActivity.interaction?.intent as? OrderCoffeeIntent {
            var response = OrderCoffeeIntentResponse()
            if orderIntent.quantity as! Int > 0 {
                response = OrderCoffeeIntentResponse(code: .success, userActivity: nil)
            } else {
                response = OrderCoffeeIntentResponse(code: .failure, userActivity: nil)
            }
            
            switch response.code {
            case .success:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let main = storyboard.instantiateViewController(withIdentifier: "Main") as! UINavigationController
                let orderListVC = storyboard.instantiateViewController(withIdentifier: "OrdersListTVC") as! OrdersListTVC
                OrderManager.makeOrder(intent: orderIntent)
                Short.donateInteraction(for: orderIntent)
                self.window?.rootViewController = main
                self.window?.makeKeyAndVisible()
                main.pushViewController(orderListVC, animated: true)
                return true
            case .failure:
                print("Failed to order")
                return true
            default:
                break
            }
        }
        return false
    }

}

