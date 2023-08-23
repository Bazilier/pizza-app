//
//  AdressModel.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 12.05.2023.
//

import Foundation

struct Address: Codable {
    let source, result, postalCode, country: String
    
    enum CodingKeys: String, CodingKey {
        case source, result
        case postalCode = "postal_code"
        case country
        
        typealias AddressResponse = [Address]
    }
}
