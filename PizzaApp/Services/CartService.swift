//
//  CartService.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 27.04.2023.
//

import Foundation

class CartService {
    
    let archiver = CartArchiver()
    
    var products: [Product]
    init() {
        products = archiver.retrieve()
    }
    
    func add (of product: Product) {
        
        if products.contains(where: { $0.id == product.id } ) {
            
            if let index = products.firstIndex(where: {$0.id == product.id }) {
                let currentCount =  products[index].count
                products[index].count = currentCount + 1
                
                
            }
        } else {
            product.count = 1
            products.append(product)
        }
        
        print(products)
        archiver.save(products)
        
    }
    
    func remove (of product: Product) {
        if products.contains(where: { $0.id == product.id }) {
            products.removeAll(where: { $0.id == product.id })
        }
    }
    
    func update (of product: Product, totalCount: Int) {
        var product = products.first(where: { $0.id == product.id })
        product?.count = totalCount
    }
}


