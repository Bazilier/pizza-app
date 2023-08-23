//
//  DescriptionCell.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 8.04.2023.
//

import UIKit
import SnapKit

class DescriptionCell: UITableViewCell {
    
    static let identifier = "DescriptionCell"
    
    var descriptionStackView: UIStackView = {
        let stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        return stackView
    }()
    
    var nameLabel: UILabel = {
        let label = Label(style: .detailsNameLabel, text: "")
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = Label(style: .detailsDescriptionLabel, text: "")
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(descriptionStackView)
        descriptionStackView.addArrangedSubview(nameLabel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        descriptionStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).inset(20)
        }
    }
    
    func update(_ product: Product) {
        nameLabel.text = product.name
        descriptionLabel.text = product.description
    }
    
    func update(_ banner: Banner) {
        nameLabel.text = banner.name
        descriptionLabel.text = banner.description
    }
}
