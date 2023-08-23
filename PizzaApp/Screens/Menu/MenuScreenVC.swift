//
//  ViewController.swift
//  task-3-02
//
//  Created by Кирилл Васильев on 3.02.2023.
//

import UIKit
import SnapKit

/*
 Responsibilities of this class:
 1. BusinessLogic (injected service) -> Service
 2. Update Model -> Service
 3. Event Handling (i.e., responding to user interactions) <- View
 4. Navigation (i.e., moving to other screens)
 */
class MenuScreenVC: UIViewController {
    
    // Create a reference to a view of type MenuScreenView. The view for this controller will be cast to this type.
    var menuView: MenuScreenView { return view as! MenuScreenView }
    
    // Create instances of productsAPI and bannersAPI to fetch data from the API.
    var productsAPI = ProductAPIClient()
    var bannersAPI = BannerAPIClient()
    
    // This function is called when the view controller's view needs to be created. Here, we create an instance of MenuScreenView and set it as the view for this view controller.
    override func loadView() {
        view = MenuScreenView.init(frame: UIScreen.main.bounds)
    }
    
    // Define a variable to hold an instance of the LaunchScreenView.
    private var launchScreenView: LaunchScreenView!
    
    // This function is called after the view controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the launch screen view and add it as a subview.
        launchScreenView = LaunchScreenView()
        view.addSubview(launchScreenView)
        launchScreenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Fetch products and banners for the menu.
        fetchProducts()
        fetchBanners()
        
        // Set up event handlers for when a price is tapped in the menu view.
        menuView.onPriceTapped = { product in
            self.showDetailScreen(product)
        }
        
        menuView.onBannerPriceTapped = { banner in
            self.showDetailScreen(banner)
        }
        
        menuView.onAddressTapped = {
            let addressViewController = AddressVС()
            
            addressViewController.onAddressSelected = { addressSuggest in
                
                print(addressSuggest.value)
                
                self.menuView.update(addressSuggest)
            }
            
            let navigationController = UINavigationController(rootViewController: addressViewController)
            self.present(navigationController, animated: true, completion: nil)
        }
        
        // Print out all available fonts. This is just for debugging and can be removed in the final code.
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        print(#line)
    }
    
    // Define functions to show the detail screen for a product or a banner.
    func showDetailScreen(_ product: Product) {
        let detailVC = ProductDetailsVC.init()
        //detailVC.product = product
        self.present(detailVC, animated: true)
        detailVC.update(product)
    }
    
    func showDetailScreen(_ banner: Banner) {
        let detailVC = ProductDetailsVC.init()
        detailVC.banner = banner
        self.present(detailVC, animated: true)
        //        detailVC.update(banner)
    }
    
    //MARK: - Business Logic
    
    // Define a function to fetch products from the API.
    func fetchProducts() {
        productsAPI.fetchProduct { products in
            DispatchQueue.main.async {
                self.menuView.update(products)
                self.productsLoaded = true
                self.dismissLaunchScreenIfNeeded()
            }
        }
    }
    
    // Define a function to fetch banners from the API.
    func fetchBanners() {
        bannersAPI.fetchBanner { banners in
            DispatchQueue.main.async {
                self.menuView.update(banners)
                self.bannersLoaded = true
                self.dismissLaunchScreenIfNeeded()
            }
        }
    }
    
    // Private variables to track if products and banners are loaded.
    private var productsLoaded = false
    private var bannersLoaded = false
    
    // This function checks if both products and banners are loaded, and if so, it removes the launch screen view.
    func dismissLaunchScreenIfNeeded() {
        if productsLoaded && bannersLoaded {
            // Animate the dismissal of the launch screen.
            UIView.animate(withDuration: 0.5, animations: {
                // Fade out the launch screen view.
                self.launchScreenView.alpha = 0
                
                // Show the tab bar as part of the animation.
                if let mainTabVC = self.tabBarController as? MainTabVC {
                    mainTabVC.tabBar.alpha = 0
                    mainTabVC.showTabBar()
                    mainTabVC.tabBar.alpha = 1
                }
            }) { _ in
                // Once the animation is complete, remove the launch screen view from the hierarchy.
                self.launchScreenView.removeFromSuperview()
            }
        }
    }
}

