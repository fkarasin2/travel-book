//
//  AppDelegate.swift
//  TravelBook
//
//  Created by Hayrullah Faruk KARAŞIN on 21.03.2022.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let configuration = ParseClientConfiguration { (ParseMutableClientConfiguration) in
                   ParseMutableClientConfiguration.applicationId = "3DMXGD7hgpo7vZyJE9inSlkdnaUw3bff5xBld8ul"
                   ParseMutableClientConfiguration.clientKey = "4koWcc8BFUhIclLMBkHaILEWCl5m7BE19q7Nz9hI"
                   ParseMutableClientConfiguration.server = "https://parseapi.back4app.com/"
                   
               }
               
               Parse.initialize(with: configuration)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

