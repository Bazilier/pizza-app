//
//  LaunchScreenView.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 10.05.2023.
//

import UIKit
import SnapKit

// Define a new class LaunchScreenView, a subclass of UIView. This class represents the custom view for the launch screen of your application.
class LaunchScreenView: UIView {
    
    // Create a private constant imageView of type UIImageView. This will display an image on the launch screen.
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "doggo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Create a private constant label of type UILabel. This will display text on the launch screen.
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Doggo Pizza"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.font = UIFont(name: Fonts.sfHollywoodHills, size: 30)
        label.textColor = .label
        return label
    }()
    
    // Create a private constant activityIndicator of type UIActivityIndicatorView. This will display a spinning indicator while the app is loading.
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .label
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    // Override the init method with frame parameter. This initializer sets up the view and adds the imageView, label, and activityIndicator as subviews.
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(imageView)
        addSubview(label)
        addSubview(activityIndicator)
        
        // Use SnapKit to create Auto Layout constraints for the imageView, label, and activityIndicator.
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.height.width.equalTo(150)
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(20)
        }
    }
    
    // This required initializer with NSCoder parameter is not implemented, since this class is not intended to be used with Interface Builder.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
