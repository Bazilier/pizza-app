//
//  Labels.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 20.05.2023.
//

import Foundation
import UIKit

enum LabelStyle: Int {
    case navigationLabel
    case bannerNameLabel
    case productNameLabel
    case productDescriptionLabel
    case detailsNameLabel
    case detailsDescriptionLabel
    case numberPriceItemsInCart
    case priceItemInCartLabel
    case emptyCartLabel
    case deliveryAddress
}

class Label: UILabel {
    
    init(style: LabelStyle, text: String) {
        super.init(frame: .zero)
        
        switch style {
        case .navigationLabel: createNavigationLabel(text: text)
        case .bannerNameLabel: createBannerNameLabel(text: text)
        case .productNameLabel: createProductNameLabel(text: text)
        case .productDescriptionLabel: createProductDescriptionLabel(text: text)
        case .detailsNameLabel: createDetailsNameLabel(text: text)
        case .detailsDescriptionLabel: createDetailsDescriptionLabel(text: text)
        case .numberPriceItemsInCart: createNumberPriceItemsInCartLabel(text: text)
        case .priceItemInCartLabel: createPriceItemInCartLabel(text: text)
        case .emptyCartLabel: createEmptyCartLabel(text: text)
        case .deliveryAddress: createDeliveryAddressButton(text: text)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createNavigationLabel(text: String) {
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func createBannerNameLabel(text: String) {
        self.text = text
        self.numberOfLines = 0
        self.font = UIFont.systemFont(ofSize: 15)
    }
    
    func createProductNameLabel(text: String) {
        self.text = text
        self.numberOfLines = 1
        self.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func createProductDescriptionLabel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 15)
        self.textColor = UIColor.secondaryLabel
        self.numberOfLines = 3
    }
    
    func createDetailsNameLabel(text: String) {
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    func createDetailsDescriptionLabel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 20)
        self.numberOfLines = 0
    }
    
    func createNumberPriceItemsInCartLabel(text: String) {
        self.text = text
    }
    
    func createPriceItemInCartLabel(text: String) {
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func createEmptyCartLabel (text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 18)
        self.textAlignment = .center
    }
    
    func createDeliveryAddressButton (text: String) {
        self.text = text
        self.textColor = .label
        self.font = .boldSystemFont(ofSize: 25)
    }
}
