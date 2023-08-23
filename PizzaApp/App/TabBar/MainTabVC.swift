//
//  ViewController.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 18.03.2023.
//

import UIKit

// Define a new class MainTabVC, a subclass of UITabBarController, which will control a tab bar interface in your application.
class MainTabVC: UITabBarController {
    
    // Define a private variable menuVC of type MenuScreenVC. This variable is instantiated using a closure that creates an instance of MenuScreenVC and sets up the tab bar item.
    private var menuVC: MenuScreenVC = {
        let controller = MenuScreenVC()
        let image = UIImage(systemName: "menucard")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let selectedImage = UIImage(systemName: "menucard.fill")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
        let tabItem = UITabBarItem.init(title: Texts.TabBar.menu, image: image, selectedImage: selectedImage)
        tabItem.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        tabItem.setTitleTextAttributes([.foregroundColor: UIColor.orange], for: .selected)
        controller.tabBarItem = tabItem
        return controller
    }()
    
    // Similarly, define a private variable cartVC of type CartScreenVC. It is also instantiated using a closure.
    private var cartVC: CartScreenVC = {
        let controller = CartScreenVC()
        let image = UIImage(systemName: "cart")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let selectedImage = UIImage(systemName: "cart.fill")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
        let tabItem = UITabBarItem.init(title: Texts.TabBar.cart, image: image, selectedImage: selectedImage)
        tabItem.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        tabItem.setTitleTextAttributes([.foregroundColor: UIColor.orange], for: .selected)
        controller.tabBarItem = tabItem
        return controller
    }()
    
    // Override the viewWillAppear method. This method is called just before the view controller's view is about to be added to a view hierarchy and before any animations are configured for showing the view.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the tab bar initially
        tabBar.isHidden = true
    }
    
    // Override the viewDidLoad method. This method is called after the view controller has loaded its view hierarchy into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Call the setup function to configure the tab bar controller.
        setup()
    }
    
    // Define a private method setup. This method sets up the tab bar's tint color and assigns the view controllers to be managed by the tab bar controller.
    private func setup() {
        tabBar.tintColor = .green
        viewControllers = [menuVC, cartVC]
    }
    
    // Define a function showTabBar to unhide the tab bar.
    func showTabBar() {
        tabBar.isHidden = false
    }
}
