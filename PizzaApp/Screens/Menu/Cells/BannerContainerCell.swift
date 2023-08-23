//
//  BannerContainerCell.swift
//  task-3-02
//
//  Created by Кирилл Васильев on 9.03.2023.
//

import UIKit

struct Screen {
    static var bounds = UIScreen.main.bounds
}

class BannerContainerCell: UITableViewCell {
    static let reuseID = "BannerContainerCell"
    
    var banners: [Banner] = []
    
    var onPriceButtonTapped: ((Banner)->())?
    
    var containerView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 160).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    var bannerLabel: UILabel = {
        let label = Label(style: .navigationLabel, text: Texts.Menu.specialOffers)
        return label
    }()
    
    lazy var bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: Screen.bounds.width * 0.6, height: Screen.bounds.width * 0.25)
        
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(BannerCollectionCell.self, forCellWithReuseIdentifier: BannerCollectionCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.backgroundColor = .gray.withAlphaComponent(0.01)
    }
    
    func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(bannerLabel)
        containerView.addSubview(bannerCollectionView)
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(contentView)
        }
        bannerLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).inset(8)
            make.left.right.equalTo(containerView).inset(16)
        }
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(bannerLabel.snp.bottom).offset(8)
            make.bottom.equalTo(contentView).inset(8)
            make.left.right.equalTo(containerView)
        }
        
    }
    
}

extension BannerContainerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionCell.reuseID, for: indexPath) as! BannerCollectionCell
        
        let banner = banners[indexPath.row]
        
        cell.onPriceButtonTapped = { banner in
            self.onPriceButtonTapped?(banner)
        }
        
        cell.update(banner)
        
        return cell
    }
    
    func update(_ banners: [Banner]) {
        self.banners = banners
        
        bannerCollectionView.reloadData()
    }
}

