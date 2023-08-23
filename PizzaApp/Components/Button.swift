//
//  Buttons.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 19.05.2023.
//

import UIKit

enum ButtonStyle: Int {
    case orange
    case red
    case bigOrange
}

class Button: UIButton {
    
    var onAction: (() -> Void)?
    
    init(style: ButtonStyle, text: String = "") {
        super.init(frame: .zero)
        
        switch style {
        case .orange: createOrangeButton(text: text)
        case .red: createRedButton(text: text)
        case .bigOrange: createBigOrangeButton(text: text)
        }
        
        self.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        self.onAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createOrangeButton(text: String) {
        self.backgroundColor = .orange.withAlphaComponent(0.1)
        self.layer.cornerRadius = 15
        self.setTitleColor(.orange, for: .normal)
        self.setTitle("", for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func createRedButton(text: String) {
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 7
        self.layer.borderColor = UIColor.systemRed.cgColor
        self.setTitleColor(.red, for: .normal)
        self.layer.borderWidth = 1
        self.setTitle("", for: .normal)
        self.contentEdgeInsets = UIEdgeInsets.init(top: 7, left: 15, bottom: 7, right: 15)
    }
    
    func createBigOrangeButton(text: String) {
        self.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.backgroundColor = .orange
        self.layer.cornerRadius = 20
        self.setTitle("", for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
}
