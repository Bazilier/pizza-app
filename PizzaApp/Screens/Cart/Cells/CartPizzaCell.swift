//  CartPizzaCell.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 17.03.2023.
//

import UIKit
import SnapKit

class CartPizzaCell: UITableViewCell {
    
    static let reuseID = "CartPizzaCell"
    
    var stepperView = CustomStepper()
    
    var onProductCountChanged: ((Product)->())?
    
    var product: Product?
    
    private var bottomStackView: UIStackView = {
        let stackView = UIStackView.init()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private var cartPizzaImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = Label(style: .productNameLabel, text: "")
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = Label(style: .productDescriptionLabel, text: "")
        return label
    }()
    
    private var nameDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private var borderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.15)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.15)
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
        return view
    }()
    
    private var priceLabel: UILabel = {
        let labelView = Label(style: .priceItemInCartLabel, text: "")
        return labelView
    }()
    
    private var spacerView: UIView = {
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacerView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return spacerView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setupStepper()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ product: Product) {
        
        self.product = product
        
        cartPizzaImageView.image = UIImage(named: product.image)
        nameLabel.text = product.name
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        print(product.count)
        
        stepperView.currentValue = product.count
    }
    
    func setupViews() {
        contentView.addSubview(cartPizzaImageView)
        contentView.addSubview(nameDescriptionStackView)
        nameDescriptionStackView.addArrangedSubview(nameLabel)
        nameDescriptionStackView.addArrangedSubview(descriptionLabel)
        contentView.addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(priceLabel)
        bottomStackView.addArrangedSubview(spacerView)
        bottomStackView.addArrangedSubview(stepperView)
        contentView.addSubview(borderLineView)
        
        stepperView.backgroundColor = .orange
        stepperView.layer.cornerRadius = 21
        
        contentView.addSubview(separatorView)
    }
    
    
    func setupConstraints() {
        cartPizzaImageView.snp.makeConstraints { make in
            make.top.left.equalTo(contentView).inset(15)
            make.bottom.lessThanOrEqualToSuperview().inset(15)
        }
        nameDescriptionStackView.snp.makeConstraints { make in
            make.top.equalTo(cartPizzaImageView).inset(5)
            make.left.equalTo(cartPizzaImageView.snp.right).offset(15)
            make.right.equalToSuperview().inset(15)
            make.centerY.equalTo(cartPizzaImageView.snp.centerY)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(8)
        }
        
        borderLineView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(15)
            make.top.equalTo(cartPizzaImageView.snp.bottom).offset(10)
        }
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(borderLineView.snp.bottom).offset(10)
            make.left.equalTo(borderLineView)
            make.bottom.right.equalToSuperview().inset(15)
        }
        stepperView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(110)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(bottomStackView.snp.bottom).offset(10)
            make.bottom.equalTo(contentView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
    }
    
    private func setupStepper() {
        stepperView.addTarget(self, action: #selector(stepperChangedValueAction), for: .valueChanged)
    }
    
    @objc private func stepperChangedValueAction(sender: CustomStepper) {
        
        
        
        print(sender)
        print(sender.currentValue)
        
        self.product?.count = sender.currentValue
        
        if let product = self.product {
            onProductCountChanged?(product)
        }
    }
}


