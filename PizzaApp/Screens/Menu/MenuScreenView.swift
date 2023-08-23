//
//  MenuScreenView.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 25.04.2023.
//

import UIKit

// This enum defines the various sections in the menu.
enum MenuSection: Int, CaseIterable {
    case hereOrAway = 0
    case banners = 1
    case products = 2
}

/*
 Responsibilities
 
 1. Configure UI
 2. View Hierarchy
 3. Layout UI
 4. Datasource/Delegate
 */

class MenuScreenView: UIView {
    
    // These closures are called when a price button is tapped.
    var onPriceTapped: ((Product)->())?
    var onBannerPriceTapped: ((Banner)->())?
    
    var onAddressTapped: (() -> Void)?
    
    // This is the data that will be displayed in the table view.
    private var products: [Product] = []
    private var banners: [Banner] = []
    
    var address: SuggestAddress?
    
    // This is the table view that will display the data.
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init()
        tableView.backgroundColor = UIColor.systemBackground
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BannerContainerCell.self, forCellReuseIdentifier: BannerContainerCell.reuseID)
        tableView.register(PizzaCell.self, forCellReuseIdentifier: PizzaCell.reuseId)
        tableView.register(HereOrAwayCell.self, forCellReuseIdentifier: HereOrAwayCell.reuseId)
        return tableView
    }()
    
    // The initialization function sets up the views and constraints.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This function updates the product data and refreshes the table view.
    func update(_ products: [Product]) {
        self.products = products
        self.tableView.reloadData()
    }
    
    // This function updates the banner data and refreshes the table view.
    func update(_ banners: [Banner]) {
        self.banners = banners
        self.tableView.reloadData()
    }
    
    func update(_ address: SuggestAddress) {
        self.address = address
        self.tableView.reloadData()
    }
    
}

// This extension contains functions that set up the views and constraints.
extension MenuScreenView {
    
    private func setupViews() {
        self.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(self)
        }
    }
}

// This extension contains a helper function to get the parent view controller of a view.
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

// These extensions make MenuScreenView conform to UITableViewDelegate and UITableViewDataSource.
extension MenuScreenView: UITableViewDelegate {
    
}

extension MenuScreenView: UITableViewDataSource {
    
    // Returns the number of sections in the table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuSection.allCases.count
    }
    
    // Returns the height of the row at the given index path.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = MenuSection.init(rawValue: indexPath.section)
        
        switch section {
        case .hereOrAway: return UITableView.automaticDimension
        case .banners: if banners.isEmpty { return 0 }
        case .products: if products.isEmpty { return 0 }
        default: return 0
        }
        return UITableView.automaticDimension
    }
    
    // Returns the number of rows in the section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = MenuSection.init(rawValue: section)
        
        switch section {
        case .hereOrAway: return 1
        case .banners: return 1
        case .products: return products.count
        default: return 0
        }
    }
    
    // Returns the cell for the row at the given index path.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = MenuSection.init(rawValue: indexPath.section)
        
        switch section {
        case .hereOrAway :
            let cell = tableView.dequeueReusableCell(withIdentifier: HereOrAwayCell.reuseId, for: indexPath) as! HereOrAwayCell
            
            
            cell.update(address)
            
            // Handles event when address button is tapped, presenting the AddressViewController
            cell.onAddressButtonTapped = { [weak self] in
                
                self?.onAddressTapped?()
            }
            return cell
            
        case .banners :
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerContainerCell.reuseID, for: indexPath) as! BannerContainerCell
            // Handles event when price button on banner is tapped.
            cell.onPriceButtonTapped = { banner in
                self.onBannerPriceTapped?(banner)
            }
            // Updates banner data in cell.
            cell.update(self.banners)
            return cell
            
        case .products:
            let cell = tableView.dequeueReusableCell(withIdentifier: PizzaCell.reuseId, for: indexPath) as! PizzaCell
            // Handles event when price button on product is tapped.
            cell.onPriceButtonTapped = { product in
                self.onPriceTapped?(product)
            }
            // Updates product data in cell.
            let product = products[indexPath.row]
            cell.update(product)
            return cell
            
        default: return UITableViewCell() // Return an empty cell if none of the sections match.
        }
    }
}
