//
//  LanguageChoice.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 31.05.2023.
//

import Foundation

enum URLType {
    case products
    case banners
}

struct URLConfigurator {
    
    var baseUrl = ""
    var language = Locale.current.language.languageCode?.identifier ?? ""
    
    init(_ type: URLType) {
        
        print(language)
        switch type {
            
        case (.products):
            let ruUrl = "https://apingweb.com/api/rest/2140dbdc5943d2192a04d89caca51c6e14/products"
            let engUrl = "https://apingweb.com/api/rest/606060573c335b357126a16337632ccd11/products"
            baseUrl = "\(language)" == "en"  ? engUrl : ruUrl
            
        case .banners:
            let ruUrl = "https://apingweb.com/api/rest/54f4ec590e37e7a3d7f908ff77ca59a32/banners"
            let engUrl = "https://apingweb.com/api/rest/31037b9448c146af121c8503e75778ef24/banners"
            baseUrl = "\(language)" == "en" ? engUrl : ruUrl
        }
    }
}
