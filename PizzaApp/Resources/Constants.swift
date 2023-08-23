//
//  Constants.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 16.05.2023.
//

import UIKit

enum Texts {
    enum Menu {
        static let delivery = NSLocalizedString("Delivery", comment: "")
        static let takeAway = NSLocalizedString("Take Away", comment: "")
        static let provideDeliveryAdd = NSLocalizedString("Provide delivery address 🚚", comment: "")
        static let provideRestaurantAdd = NSLocalizedString("Provide restaurant address 🍕", comment: "")
        static let specialOffers = NSLocalizedString("Special offers 🥲", comment: "")
        static let deliveryAddress = NSLocalizedString("Delivery Address", comment: "")
    }
    enum Detail {
        static let addToCart = NSLocalizedString("Add to cart", comment: "")
        
        static func addToCart (_ price: Double) -> String {
            return "\(Texts.Detail.addToCart) ($\(price))"
        }
    }
    enum Cart {
        static let emptyCart = NSLocalizedString("Ooohs, your cart is empty 🤷‍♂️", comment: "")
        static let goToMenu = NSLocalizedString("Go to menu", comment: "")
        static let makeOrder = NSLocalizedString("Order", comment: "")
        static let itemsForPrice = NSLocalizedString("items for", comment: "")
        
        static func totalItemsAndPrice(_ count: Int, _ totalPrice: Double) -> String {
            let formattedPrice = String(format: "%.2f", totalPrice)
            
            let lastDigit = count % 10
            let lastTwoDigits = count % 100
            
            let itemCountString: String
            
            if lastTwoDigits >= 11 && lastTwoDigits <= 19 {
                itemCountString = "\(count) товаров"
            } else {
                switch lastDigit {
                case 1:
                    itemCountString = "\(count) товар"
                case 2...4:
                    itemCountString = "\(count) товара"
                default:
                    itemCountString = "\(count) товаров"
                }
            }
            
            let itemsForPrice = NSLocalizedString("items for", comment: "")
            let localizedItemsFor = "\(itemCountString) \(itemsForPrice)"
            
            return "\(localizedItemsFor) $\(formattedPrice)"
        }
        
        static func makeOrder(_ price: Double) -> String {
            var formattedPrice = String(format: "%.2f", price)
            return "\(Texts.Cart.makeOrder) ($\(formattedPrice))"
        }
    }
    enum TabBar {
        static let menu = NSLocalizedString("Menu", comment: "")
        static let cart = NSLocalizedString("Cart", comment: "")
    }
}

enum Layout {
    static let offset32 = 32
    static let offset16 = 16
    static let offset12 = 12
    static let offset8 = 8
}

enum Fonts {
    static let sfHollywoodHills = "SFHollywoodHills"
}

enum Images {
    static let logo = "dog"
}

enum Colors {
    static let lightGray: UIColor = .lightGray
}

