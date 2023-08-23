//
//  CartHeaderView.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 4.05.2023.
//

import UIKit
import SnapKit

class CartHeaderView: UIView {
    
    private var totalLabel: UILabel = {
        let label = Label(style: .numberPriceItemsInCart, text: "")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        
        self.backgroundColor = .orange
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        self.addSubview(totalLabel)
    }
    
    private func setupConstraints() {
        totalLabel.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(self).inset(10)
        }
    }
    
    func update(_ products: [Product]) {
        
        var count = 0
        var totalPrice: Double = 0.0
        
        for product in products {
            count += product.count
            totalPrice += Double(product.count) * product.price
        }
        totalLabel.text = Texts.Cart.totalItemsAndPrice(count, totalPrice)
    }
}
