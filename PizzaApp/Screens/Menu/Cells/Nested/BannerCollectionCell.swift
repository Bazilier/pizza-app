//
//  BannerCollectionCell.swift
//  task-3-02
//
//  Created by Кирилл Васильев on 9.03.2023.
//

import UIKit

class BannerCollectionCell: UICollectionViewCell {
    static let reuseID = "BannerCollectionCell"
    
    var banner: Banner?
    
    var onPriceButtonTapped: ((Banner)->())?
    
    var productImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage(named: "")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var namelabel: UILabel = {
        let label = Label(style: .bannerNameLabel, text: "")
        return label
    }()
    
    var priceButton = Button.init(style: .orange)
    
    var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .tertiarySystemBackground
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.layer.cornerRadius = 10
        stackView.layer.shadowColor = UIColor.gray.cgColor
        stackView.layer.shadowOpacity = 0.4
        stackView.layer.shadowOffset = .zero
        stackView.layer.shadowRadius = 3
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        
        priceButton.onAction = {
            guard let banner = self.banner else { return }
            self.onPriceButtonTapped?(banner)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        verticalStackView.addArrangedSubview(namelabel)
        verticalStackView.addArrangedSubview(priceButton)
        
        horizontalStackView.addArrangedSubview(productImageView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        
        contentView.addSubview(horizontalStackView)
    }
    
    func setupConstraints() {
        horizontalStackView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(contentView)
        }
        
        productImageView.snp.makeConstraints { make in
            make.height.equalTo(horizontalStackView.snp.height).multipliedBy(0.9)
            make.width.equalTo(horizontalStackView.snp.height).multipliedBy(0.9)
            make.left.equalTo(horizontalStackView.snp.left).inset(20)
        }
        verticalStackView.snp.makeConstraints { make in
            make.right.equalTo(horizontalStackView).inset(30)
        }
    }
    
    func update(_ banner: Banner) {
        productImageView.image = UIImage(named: banner.image)
        namelabel.text = banner.name
        priceButton.setTitle("$ \(banner.price)", for: .normal)
    }
    
    
}
