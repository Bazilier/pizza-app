//
//  SceneDelegate.swift
//  task-3-02
//
//  Created by Кирилл Васильев on 3.02.2023.
//

// Import the UIKit framework, which provides the core tools that you need to build apps for iOS.
import UIKit

// Declare SceneDelegate class. It's a subclass of UIResponder and conforms to the UIWindowSceneDelegate protocol.
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // Declare a UIWindow property. UIWindow is a type of object that manages and coordinates the interactions of one or more UIView objects on a screen.
    var window: UIWindow?


    // This method is called by the system as part of the scene's lifecycle. It is called when a new scene has been created and is about to be displayed.
    // Here, the UIWindow is created and assigned a root view controller (MainTabVC), then made visible.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Ensure that the scene is of type UIWindowScene. If not, return.
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Initialize the window with the windowScene.
        window = UIWindow(windowScene: windowScene)
        
        // Set the root view controller of the window to MainTabVC.
        window?.rootViewController = MainTabVC()
        // Make the window key and visible.
        window?.makeKeyAndVisible()
    }

    // This method is called when a scene has disconnected from the app.
    // This might happen when a user closes an app window or when the system decides to reclaim resources. Any cleanup related to the scene should be done here.
    func sceneDidDisconnect(_ scene: UIScene) { }

    // This method is called when a scene transitions from an inactive state to an active state.
    // It can be used to restart any tasks that were paused when the scene became inactive.
    func sceneDidBecomeActive(_ scene: UIScene) { }

    // This method is called when a scene transitions from an active state to an inactive state.
    // This might occur due to temporary interruptions, like an incoming phone call.
    func sceneWillResignActive(_ scene: UIScene) { }

    // This method is called when a scene transitions from the background to the foreground.
    // It can be used to undo any changes made when the app entered the background.
    func sceneWillEnterForeground(_ scene: UIScene) { }

    // This method is called when a scene transitions from the foreground to the background.
    // It can be used to save data, release shared resources, or store enough state information to restore the scene back to its current state.
    func sceneDidEnterBackground(_ scene: UIScene) { }

}
