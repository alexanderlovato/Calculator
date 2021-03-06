//
//  AppDelegate.swift
//  Calculator2
//
//  Created by Alexander Lovato on 10/10/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let transitionController = NavigationTransitionController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //        UINavigationBar.appearance().tintColor = UIColor.black
        // setup navigation delegate
        let rootNavigationController = self.window!.rootViewController as! UINavigationController
        rootNavigationController.delegate = transitionController
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        CalculatorController.sharedController.saveToPersistentStorage()
        CalculatorController.sharedController.saveToHistoryStorage()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        CalculatorController.sharedController.saveToPersistentStorage()
        CalculatorController.sharedController.saveToHistoryStorage()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        CalculatorController.sharedController.saveToPersistentStorage()
        CalculatorController.sharedController.saveToHistoryStorage()
    }
    
    
}

