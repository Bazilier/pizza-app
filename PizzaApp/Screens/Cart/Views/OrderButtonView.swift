//
//  OrderButtonPanel.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 24.03.2023.
//

import UIKit

class OrderButtonView: UIView {
    var orderButton = Button.init(style: .bigOrange)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.backgroundColor = .clear
        self.addSubview(orderButton)
    }
    
    private func setupConstraints(){
        orderButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(self).inset(12)
            make.left.right.equalTo(self).inset(15)
        }
    }
    
    func update(_ products: [Product]) {
        var totalPrice: Double = 0
        
        for product in products {
            totalPrice = totalPrice + Double(product.count) * product.price
        }
        
        orderButton.setTitle(Texts.Cart.makeOrder(totalPrice), for: .normal)
    }
}
