//
//  DeliveryAdressVC.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 11.05.2023.
//


import UIKit
import SnapKit

class AddressVС: UIViewController {
    
    var onAddressSelected: ((SuggestAddress) -> Void)?
    var CityViewCell = CitySelectionCell()
    var addresses: [SuggestAddress] = []
    var timer: Timer?
    
    var addressLabel: UILabel = {
        let label = Label(style: .deliveryAddress, text: Texts.Menu.deliveryAddress)
        return label
    }()
    
    var addressTextField: UITextField = {
        var field = UITextField()
        field.placeholder = "Enter your address"
        field.textColor = .label
        field.textAlignment = .left
        field.backgroundColor = .secondarySystemBackground
        field.font = UIFont.systemFont(ofSize: 15)
        field.layer.cornerRadius = 3
        let width = UIScreen.main.bounds.width
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        
        field.heightAnchor.constraint(equalToConstant: 0.1 * width).isActive = true
        field.widthAnchor.constraint(equalToConstant: 0.65 * width).isActive = true
        return field
    }()
    lazy var tableView: UITableView = {
        var table = UITableView()
        table.backgroundColor = .systemBackground
        table.separatorInset = UIEdgeInsets.zero
        table.delegate = self
        table.dataSource = self
        table.register(CitySelectionCell.self, forCellReuseIdentifier: CitySelectionCell.reuseId)
        return table
    }()
    
    @objc func buttonTapped(){
        
        API.shared.getSuggestions(city: addressTextField.text!) { [weak self] data in
            DispatchQueue.main.async {
                guard let self else {return}
                self.update(addresses: data)
            }
        }
    }
    
    var address: [Address] = []
    
    var suggestAddress: [SuggestAddress] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressTextField.delegate = self
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addressTextField.becomeFirstResponder()
    }
    
    func setupViews(){
        view.backgroundColor = .systemBackground
        view.addSubview(addressTextField)
        view.addSubview(tableView)
        view.addSubview(addressLabel)
    }
    
    func setupConstraints(){
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(view).inset(60)
            make.left.equalTo(addressTextField.snp.left)
        }
        
        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(addressLabel).inset(40)
            make.centerX.equalTo(view)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaInsets)
            make.left.right.equalTo(addressTextField)
        }
    }
    func update(addresses: [SuggestAddress]){
        self.addresses = addresses
        tableView.reloadData()
    }
    
}

extension AddressVС: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CitySelectionCell.reuseId, for: indexPath) as! CitySelectionCell
        let address = addresses[indexPath.row]
        cell.update(address)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let address = addresses[indexPath.row]
        
        onAddressSelected?(address)
    }
    
}

extension AddressVС: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        timer?.invalidate()  // if there is already a timer, invalidate it before starting a new one
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in // 0.5 second delay
            guard let self = self else { return }
            guard let searchText = textField.text, !searchText.isEmpty else {
                self.addresses = [] // Clear the addresses if there is no text
                self.tableView.reloadData() // Reload the table
                return
            }
            self.buttonTapped() // call your search function
        })
        return true
    }
}


