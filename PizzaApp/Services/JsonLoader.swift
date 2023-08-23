//
//  JsonLoader.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 6.04.2023.
//

import Foundation

final class JsonLoader {
    func loadProducts(filename: String) -> [Product]? {
        
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode(ProductResponse.self, from: data)
                return jsonData.products
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    func loadBanners(filename: String) -> [Banner]? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                let jsonData = try JSONDecoder().decode(BannerResponse.self, from: data)
                return jsonData.banners
            } catch {
                print ("error:\(error)")
            }
        }
        return nil
    }
}
