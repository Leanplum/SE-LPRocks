//
//  AppDelegate.swift
//  LpRocks
//
//  Created by Trig Gullberg on 2/3/18.
//  Copyright © 2018 Trig Gullberg. All rights reserved.
//

import UIKit
#if DEBUG
    import AdSupport
#endif
import Leanplum
import LeanplumUIEditor
import UserNotifications

var welcomeMessage : LPVar!
var callToActionText : LPVar!
var mainButtonText : LPVar!
var onboardingOption : LPVar!
var newFeatureOn : LPVar!
var newOnBoardFlow : LPVar!
var backGroundImage : LPVar!
var exampleDictionary : LPVar!
var exampleArray : LPVar!
var audioFile : LPVar!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Successfully registered for notifications!")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.newData)
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Define the custom actions.
        let acceptAction = UNNotificationAction(identifier: "OPEN_ACTION",
                                                title: "Open",
                                                options: UNNotificationActionOptions(rawValue: 0))
        let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION",
                                                 title: "Decline",
                                                 options: UNNotificationActionOptions(rawValue: 0))
        // Define the notification type
        let standardPushCategory =
            UNNotificationCategory(identifier: "STANDARD_PUSH",
                                   actions: [acceptAction, declineAction],
                                   intentIdentifiers: [],
                                   hiddenPreviewsBodyPlaceholder: "",
                                   options: .customDismissAction)
        // Register the notification type.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.setNotificationCategories([standardPushCategory])
        // Override point for customization after application launch.
        //iOS-10
        if #available(iOS 10.0, *){
            let userNotifCenter = UNUserNotificationCenter.current()
            
            userNotifCenter.requestAuthorization(options: [.badge,.alert,.sound]){ (granted,error) in
                //Handle individual parts of the granting here.
            }
            UIApplication.shared.registerForRemoteNotifications()
        }
            //iOS 8-9
        else if #available(iOS 8.0, *){
            let settings = UIUserNotificationSettings.init(types: [UIUserNotificationType.alert,UIUserNotificationType.badge,UIUserNotificationType.sound],
                                                           categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
            //iOS 7
        else{
            UIApplication.shared.registerForRemoteNotifications(matching:
                [UIRemoteNotificationType.alert,
                 UIRemoteNotificationType.badge,
                 UIRemoteNotificationType.sound])
        }
        
        initLeanplum()
        
        Leanplum.track("Purchase", withValue:0.0000000523)
        
        return true
    }
    
    func initLeanplum() {
        // init variables always before Leanplum.start()
        welcomeMessage = LPVar.define("welcomeMessage", with: "Welcome to Leanplum!")
        callToActionText = LPVar.define("callToActionText", with: "Call to Action")
        mainButtonText = LPVar.define("mainButtonText", with: "Next")
        onboardingOption = LPVar.define("onboardingOption", with: 1)
        newFeatureOn = LPVar.define("newFeatureOn", with: false)
        backGroundImage = LPVar.define("backGroundImage", withFile: "n4.jpg")
        newOnBoardFlow = LPVar.define("newOnBoardFlow", with: false)
        exampleArray = LPVar.define("exampleArray", with: ["1","2","three","four"])
        exampleDictionary = LPVar.define("exampleDictionary", with: [
            "name": "Turbo Boost",
            "price": 150,
            "speedMultiplier": 1.5,
            "timeout": 15])
        audioFile = LPVar.define("audioFile", withFile: "sample.m4a")
        
        
        
        let filePath = Bundle.main.resourcePath!
        
        print(filePath)
        
        do {
            let fm = FileManager.default
            let items = try fm.contentsOfDirectory(atPath: filePath)
            
            for item in items {
                print("Found \(item)")
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
        
        Leanplum.onVariablesChanged({
            NSLog((welcomeMessage?.stringValue())!)
            
            Leanplum.track("VariablesUpdated")
        })
        
        // Insert your API keys here.
        #if DEBUG
            Leanplum.setDeviceId(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
            Leanplum.setAppId("app_rKwNADoDN5YDPalKRjcaIbLv22iD2DKLG5fXgtab7fc",
                              withDevelopmentKey:"dev_TgboGJjukA3QBy7uIXgwDZTD6Q99MRQYzyK6gR7v9vA")
//        Leanplum.setAppId("app_9tZMPilWxxqEiJcm0tADID4orpWEGPvfWejfyhLiGGg",
//                                    withDevelopmentKey:"dev_p2suivNttiQgK4z9QTfBKMxRFxQ8xNCs0CloQn3Jg58")
        #else
            Leanplum.setAppId("app_rKwNADoDN5YDPalKRjcaIbLv22iD2DKLG5fXgtab7fc",
                              withProductionKey: "prod_o10RUtXEZ8fvaTNldqDQQrzJpmxgO2YMXBvAgoVF10U")
//        Leanplum.setAppId("app_9tZMPilWxxqEiJcm0tADID4orpWEGPvfWejfyhLiGGg",
//                          withProductionKey: "prod_RjcG2pda4AMlIDtH1LYfRrfhRbpTdWGeVM7UHNoBGeQ")
        #endif
        
        Leanplum.start(withUserId: "test1")
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
    
    


}

