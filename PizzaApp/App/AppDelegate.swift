//
//  AppDelegate.swift
//  task-3-02
//
//  Created by Кирилл Васильев on 3.02.2023.
//

// Import the UIKit framework, which provides the core tools that you need to build apps for iOS.
import UIKit

// Here we declare AppDelegate class as the main entry point of the application. This class is a subclass of UIResponder and conforms to the UIApplicationDelegate protocol.
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // This method is called after the application has launched. This is where you might do some basic setup, such as setting up analytics, initializing SDKs, etc.
    // The return value indicates whether the application should continue launching. Normally, you should return true to indicate a successful launch.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    // This method is part of the UISceneSession life cycle. It's called when a new UISceneSession (a representation of an app's content shown in a specific UIWindowScene) is created.
    // The method returns a UISceneConfiguration object which is used to configure and create the new scene. This configuration includes information about the scene's role and the classes used to manage the scene.
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // This method is called when a UISceneSession is discarded. This can happen when a user closes a window (on Mac), or when the system decides to free up resources.
    // Any cleanup related to the discarded scene session should be done here.
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
