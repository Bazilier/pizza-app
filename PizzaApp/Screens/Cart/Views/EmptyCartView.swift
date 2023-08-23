// EmptyCartView.swift
// PizzaApp
//
// Created by Кирилл Васильев on 8.05.2023.
//

import UIKit
import SnapKit

class EmptyCartView: UIView {
    
    var onGoToMenuTapped: (() -> Void)?
    
    private let emptyCartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "emptycartdoggo")
        
        return imageView
    }()
    
    
    private let emptyCartMessageLabel: UILabel = {
        let label = Label.init(style: .emptyCartLabel, text: Texts.Cart.emptyCart)
        return label
    }()
    
    private let goToMenuButton: UIButton = {
        let button = Button(style: .bigOrange)
        button.setTitle(Texts.Cart.goToMenu, for: .normal)
        button.addTarget(self, action: #selector(goToMenuButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        setupViews()
        setupConstraints()
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(emptyCartImageView)
        addSubview(emptyCartMessageLabel)
        addSubview(goToMenuButton)
    }
    
    private func setupConstraints() {
        emptyCartImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
        
        emptyCartMessageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyCartImageView.snp.bottom).offset(16)
            make.width.equalToSuperview()
            make.height.equalTo(25)
        }
        
        goToMenuButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyCartMessageLabel.snp.bottom).offset(16)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(50)
        }
    }
    
    @objc private func goToMenuButtonTapped() {
        onGoToMenuTapped?()
    }
}
