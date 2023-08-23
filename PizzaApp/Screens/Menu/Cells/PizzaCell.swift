//
//  TableViewCell.swift
//  task-3-02
//
//  Created by Кирилл Васильев on 3.02.2023.
//

import UIKit

class PizzaCell: UITableViewCell {

    static let reuseId = "PizzaCell"
    
    var product: Product?
    
    var onPriceButtonTapped: ((Product)->())?

    private var verticalStackView: UIStackView = {
        let stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets.init(top: 16, leading: 0, bottom: 5, trailing: 0)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    private var horizontalStackView: UIStackView = {
        let stackView = UIStackView.init()
        stackView.axis = .horizontal
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 16

        return stackView
    }()

    private var productNameLabel: UILabel = {
        let label = Label(style: .productNameLabel, text: "")
        return label
    }()

    private var productDescriptionLabel: UILabel = {
        let label = Label(style: .productDescriptionLabel, text: "")
        return label
    }()
    
    var priceButton = Button(style: .red)

    private var headingLabel: UILabel = {
        let heading = UILabel()
        heading.text = ""
        heading.font = UIFont.boldSystemFont(ofSize: 25)

        return heading
    }()

    private var productImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage(named: "ham-mushrooms")
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        setupViews()
        setupConstraints()
        
        priceButton.onAction = {
            guard let product = self.product else { return }
            self.onPriceButtonTapped?(product)
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.01)
        selectionStyle = .none
    }

    private func setupViews(){
        contentView.addSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(productNameLabel)
        verticalStackView.addArrangedSubview(productDescriptionLabel)
        verticalStackView.addArrangedSubview(priceButton)

        horizontalStackView.addArrangedSubview(productImageView)
        horizontalStackView.addArrangedSubview(verticalStackView)
    }

    private func setupConstraints(){

        horizontalStackView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(contentView)
        }
    }

    func update(_ product: Product) {
        self.product = product
        productNameLabel.text = product.name
        productDescriptionLabel.text = product.description
        priceButton.setTitle("$ \(product.price)", for: .normal)
        productImageView.image = UIImage(named: product.image)
    }

}
