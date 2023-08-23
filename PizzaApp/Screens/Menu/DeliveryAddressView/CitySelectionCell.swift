//
//  CitySelectionCell.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 12.05.2023.
//

import UIKit
import SnapKit

// Defining the CitySelectionCell class that inherits from UITableViewCell
class CitySelectionCell: UITableViewCell{
    
    // A static constant for the cell reuse identifier
    static let reuseId = "CitySelectionCell"
    
    // The label for the city's name
    var cityName: UILabel = {
        // Initialize a new UILabel
        var label = UILabel()
        // Align the text to the left
        label.textAlignment = .left
        // Set the color of the text
        label.textColor = .label
        // Set the font and size of the text
        label.font = UIFont.boldSystemFont(ofSize: 15)
        // Return the configured label
        return label
    }()
    
    // Required initializer from the NSCoder class
    // In this case, we want to prevent initializing the cell from a coder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Override the default initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // Call the parent class initializer
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Call the function to setup the views
        setupViews()
        // Call the function to setup the constraints
        setupConstraints()
    }
    
    // Function to setup the views
    func setupViews(){
        // Set the background color of the content view
        contentView.backgroundColor = .systemBackground
        // Add the cityName label to the contentView
        contentView.addSubview(cityName)
    }
    
    // Function to setup the constraints
    func setupConstraints(){
        // Use SnapKit to make the constraints
        cityName.snp.makeConstraints { make in
            // Make the label fill the entire content view
            make.edges.equalTo(contentView)
        }
    }
    
    // Function to update the city's name with a new address
    func update(_ address: SuggestAddress){
        // Set the text of the cityName label to the value of the address
        cityName.text = "\(address.value)"
    }
}


