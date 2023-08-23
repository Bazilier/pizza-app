//
//  CartScreenVC.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 17.03.2023.
//

import UIKit
import SnapKit

class CartScreenVC: UIViewController, ConstraintRelatableTarget {
    
    var cartService = CartService()
    
    var cartHeaderView = CartHeaderView()
    var orderButtonView = OrderButtonView()
    
    var products: [Product] = []
    
    var emptyCartView: EmptyCartView = {
        let view = EmptyCartView()
        view.isHidden = true
        return view
    }()
    
    var cartNaviLabel: UILabel = {
        let label = Label(style: .navigationLabel, text: "Cart")
        label.textAlignment = .center
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        tableView.backgroundColor = .clear
        view.backgroundColor = .clear
        tableView.backgroundView = view
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartPizzaCell.self, forCellReuseIdentifier: CartPizzaCell.reuseID)
        return tableView
    }()
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.alpha = 0
        
        setupViews()
        setupConstraints()
        updateViewVisibility()
        
        emptyCartView.onGoToMenuTapped = { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self?.tabBarController?.selectedIndex = 0
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        products = cartService.archiver.retrieve()
        
        tableView.reloadData()
        
        cartHeaderView.update(products)
        orderButtonView.update(products)
        updateViewVisibility()
        
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 1
        }
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(orderButtonView)
        view.addSubview(cartNaviLabel)
        view.addSubview(emptyCartView)
        
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(cartNaviLabel.snp.bottom)
            make.bottom.equalTo(orderButtonView.snp.top)
        }
        
        orderButtonView.snp.makeConstraints { make in
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        cartNaviLabel.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(view).inset(55)
            
            emptyCartView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    func updateViewVisibility() {
        emptyCartView.isHidden = !products.isEmpty
        tableView.isHidden = products.isEmpty
        orderButtonView.isHidden = products.isEmpty
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            // Clear the cart
            products.removeAll()
            cartService.archiver.save(products)
            
            // Update the UI
            tableView.reloadData()
            cartHeaderView.update(products)
            orderButtonView.update(products)
            updateViewVisibility()
            
            // Optional: Provide some user feedback, like a vibration or alert
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
    
}



extension CartScreenVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        cartHeaderView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30)
        
        return cartHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

extension CartScreenVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartPizzaCell.reuseID, for: indexPath) as! CartPizzaCell
        
        cell.onProductCountChanged = { [weak self] product in
            guard let self = self else { return }
            if let index = self.products.firstIndex(where: { $0.id == product.id }) {
                
                self.products[index].count = product.count
                
                cell.stepperView.setDecreaseButtonEnabled(false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: DispatchWorkItem {
                    if product.count == 0 {
                        self.products.remove(at: index)
                    }
                    self.cartService.archiver.save(self.products)
                    self.tableView.reloadData()
                    self.cartHeaderView.update(self.products)
                    self.orderButtonView.update(self.products)
                    self.updateViewVisibility()
                    
                    cell.stepperView.setDecreaseButtonEnabled(true)
                })
            }
        }
        
        let product = products[indexPath.row]
        
        cell.update(product)
        
        return cell
    }
}








