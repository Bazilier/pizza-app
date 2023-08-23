//
//  HereOrAwayCell.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 7.05.2023.
//

import UIKit
import SnapKit



class HereOrAwayCell: UITableViewCell {
    
    var onAddressButtonTapped: (() -> Void)?
    
    enum DeliveryType: Int {
        case delivery = 0
        case takeaway
    }
    
    var deliverType: DeliveryType = .delivery
    
    static let reuseId = "HereOrAwayCell"
    
    private let backroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.15)
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let segmentedControl: UISegmentedControl = {
        let items = [Texts.Menu.delivery, Texts.Menu.takeAway]
        let control = UISegmentedControl.init(items: items)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return control
    }()
    
    func update(_ address: SuggestAddress?) {
        if let addressValue = address?.value {
            
            adressButton.setTitle(addressValue, for: .normal)
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        let deliveryType = DeliveryType(rawValue: selectedIndex)
        
        switch deliveryType {
        case .delivery:
            
            self.deliverType = .delivery
            
            print("Option 1 selected")
            adressButton.setTitle(Texts.Menu.provideDeliveryAdd, for: .normal)
            adressButton.setTitleColor(.label, for: .normal)
            adressButton.addTarget(self, action: #selector(addressButtonTapped), for: .touchUpInside)
            
        case .takeaway:
            
            self.deliverType = .takeaway
            
            print("Option 2 selected")
            adressButton.setTitle(Texts.Menu.provideRestaurantAdd, for: .normal)
            adressButton.setTitleColor(.label, for: .normal)
            adressButton.removeTarget(self, action: #selector(addressButtonTapped), for: .touchUpInside)
            
        default:
            print("Invalid selection")
        }
    }
    
    private let adressButton: UIButton = {
        let button = UIButton()
        //        button.setTitle("Укажите адрес доставки ➡️", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
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
        
        contentView.addSubview(backroundView)
        
        backroundView.addSubview(segmentedControl)
        
        backroundView.addSubview(separatorView)
        
        backroundView.addSubview(adressButton)
        
        switch deliverType {
            
        case .delivery:
            adressButton.setTitle(Texts.Menu.provideDeliveryAdd, for: .normal)
            adressButton.setTitleColor(.label, for: .normal)
        case .takeaway:
            adressButton.setTitle(Texts.Menu.provideRestaurantAdd, for: .normal)
            adressButton.setTitleColor(.label, for: .normal)
        }
        
        adressButton.addTarget(self, action: #selector(addressButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        backroundView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).inset(10)
            make.left.equalTo(contentView).offset(Layout.offset16)
            make.right.equalTo(contentView).inset(15)
            
            
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.centerX.equalTo(backroundView)
            make.top.equalTo(backroundView).offset(15)
            make.width.equalTo(backroundView).multipliedBy(0.85)
        }
        
        separatorView.snp.makeConstraints { make in
            make.centerX.equalTo(backroundView)
            make.top.equalTo(segmentedControl.snp.bottom).offset(15)
            make.width.equalTo(backroundView).multipliedBy(0.85)
            make.height.equalTo(0.7)
        }
        
        adressButton.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.bottom.equalTo(contentView.snp.bottom).inset(20)
        }
    }
    
    func updateAddressButtonTitle(_ newTitle: String) {
        adressButton.setTitle(newTitle, for: .normal)
    }
    
    @objc private func addressButtonTapped() {
        onAddressButtonTapped?()
    }
}

