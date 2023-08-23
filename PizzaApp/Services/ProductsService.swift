//
//  ProductsService.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 16.03.2023.
//

import Foundation

class ProductsService {
    
    var jsonLoader = JsonLoader.init()
    
    func fetchProducts() -> [Product] {
        
        let products = jsonLoader.loadProducts(filename: "products")
        
        return products ?? []
    }
}
