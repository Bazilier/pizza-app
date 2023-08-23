//
//  CartArchiver.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 10.04.2023.
//

import Foundation

protocol CartArchiverInput {
    func save(_ products: [Product])
    func retrieve() -> [Product]
}

final class CartArchiver: CartArchiverInput {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "Products"
    
    func save(_ products: [Product]) {
        
        do {
            let data = try encoder.encode(products)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieve() -> [Product] {  //метод получить
        
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            let array = try decoder.decode(Array<Product>.self, from: data)
            return array
        } catch {
            print(error)
        }
        return []
    }
}
