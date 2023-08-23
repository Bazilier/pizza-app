//
//  BannersService.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 22.04.2023.
//

import Foundation

class BannersService {
    
    var jsonLoader = JsonLoader.init()
    
    func fetchBanners() -> [Product] {
        
        let banners = jsonLoader.loadProducts(filename: "banners")
        
        return banners ?? []
    }
}
