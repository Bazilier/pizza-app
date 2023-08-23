//
//  ImageCellTableViewCell.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 8.04.2023.
//

import UIKit
import SnapKit

class ImageCell: UITableViewCell {
    
    static let identifier = "ImageCell"
    
    var productImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage(named: "")
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(productImageView)
    }
    
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.7)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.centerX.equalTo(contentView)
            
        }
    }
    
    func update(_ product: Product) {
        productImageView.image = UIImage(named: product.image)
    }
    
    func update(_ banner: Banner) {
        productImageView.image = UIImage(named: banner.image)
    }
}
