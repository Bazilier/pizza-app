//
//  Product.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 16.03.2023.
//

import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable {
    let products: [Product]
}

// MARK: - Product
class Product: Codable {
    let id: Int
    let name, description: String
    let price: Double
    let image: String
    var count: Int
    
    init(id: Int, name: String, description: String, price: Double, image: String, count: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.image = image
        self.count = count
    }
}

