//
//  AppDelegate.swift
//  ViperWeather
//
//  Created by Dmitriy Utmanov on 29/02/16.
//  Copyright © 2016 Dmitriy Utmanov. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    let serviceLocatorAssembler = ServiceLocatorAssembler()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.configureAppearance()
        
        let config = Realm.Configuration(schemaVersion: 7, migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        print(config.fileURL)
        
        let rootAssembler = serviceLocatorAssembler.resolver.resolve(RootAssembler.self)!
        rootAssembler.presentRootViewController(fromViewController: window!.rootViewController!)

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    func configureAppearance() {
        window?.backgroundColor = MaterialColor.blackColor()
        window?.tintColor = MaterialColor.lightBlueColor()

        UINavigationBar.appearance().barTintColor = MaterialColor.lightBlueColor()
        UINavigationBar.appearance().tintColor = MaterialColor.whiteColor()

        let titleTextAttributes: [String : AnyObject] = [NSForegroundColorAttributeName: MaterialColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
        
        UISearchBar.appearance().barTintColor = MaterialColor.lightBlueColor()
        UISearchBar.appearance().tintColor = MaterialColor.whiteColor()
        if #available(iOS 9.0, *) {
            UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).tintColor = MaterialColor.blackColor()
        } else {
            UITextField.appearanceWhenContainedWithin(UISearchBar.self).tintColor = MaterialColor.blackColor()
        }
        
        UITextField.appearance().keyboardAppearance = .Dark
        UITextView.appearance().keyboardAppearance = .Dark
    }
    
}

