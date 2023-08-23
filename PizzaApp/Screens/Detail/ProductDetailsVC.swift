//
//  PizzaDetailsVC.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 7.04.2023.
//

import UIKit
import SnapKit

class ProductDetailsVC: UIViewController {
    
    var product: Product?
    var banner: Banner?
    
    let cartService = CartService()
    
    enum CellType: Int, CaseIterable {
        case image
        case description
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.identifier)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.identifier)
        
        return tableView
    }()
    
    lazy var cartButton = Button(style: .bigOrange)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        cartButton.onAction = {
            if let product = self.product {
                self.cartService.add(of: product)
            }
            self.dismiss(animated: true)
            
        }
    }
    
    func setupViews() {
        view.addSubview(tableView)
        view.addSubview(cartButton)
        view.backgroundColor = .lightGray
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view)
        }
        cartButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
            make.width.equalTo(view).multipliedBy(0.9)
            make.centerX.equalToSuperview()
        }
    }
    
    //MARK: - Public
    func update(_ product: Product) {
        self.product = product
        cartButton.setTitle(Texts.Detail.addToCart(product.price), for: .normal)
    }
    
}

extension ProductDetailsVC: UITableViewDelegate {
    
}

extension ProductDetailsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellType.allCases.count //2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = CellType.init(rawValue: indexPath.row)
        
        switch cellType {
            
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
            
            if let product = product {
                cell.update(product)
            }
            
            return cell
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.identifier, for: indexPath) as! DescriptionCell
            
            if let product = product {
                cell.update(product)
            }
            
            return cell
        default: return UITableViewCell()
        }
    }
}
