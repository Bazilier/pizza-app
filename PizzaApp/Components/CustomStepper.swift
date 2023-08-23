//
//  CustomStepper.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 24.03.2023.
//

import UIKit

class CustomStepper: UIControl {
    
    var currentValue = 1 {
        didSet {
            currentValue = currentValue > 0 ? currentValue : 0
            currentStepValueLabel.text = "\(currentValue)"
        }
    }
    private lazy var decreaseButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("-", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var currentStepValueLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.text = "\(currentValue)"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: UIFont.Weight.regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        addSubview(decreaseButton)
        addSubview(currentStepValueLabel)
        addSubview(increaseButton)
    }
    
    func setupConstraints() {
        decreaseButton.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(snp.height)
        }
        
        currentStepValueLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(decreaseButton.snp.right).offset(8)
            make.width.equalTo(snp.height)
        }
        
        increaseButton.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(snp.height)
            make.left.equalTo(currentStepValueLabel.snp.right).offset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        switch sender {
        case decreaseButton:
            currentValue -= 1
        case increaseButton:
            currentValue += 1
        default:
            break
        }
        sendActions(for: .valueChanged)
    }
    func setDecreaseButtonEnabled(_ isEnabled: Bool) {
        decreaseButton.isEnabled = isEnabled
    }
}
