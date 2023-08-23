//
//  Banner.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 22.04.2023.
//

import Foundation

// MARK: - BannerResponse
struct BannerResponse: Codable {
    let banners: [Banner]
}

// MARK: - Product
class Banner: Codable {
    let id: Int
    let name, description: String
    let price: Double
    let image: String
    var count: Int? = 0
    
    init(id: Int, name: String, description: String, price: Double, image: String, count: Int? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.image = image
        self.count = count
    }
}

