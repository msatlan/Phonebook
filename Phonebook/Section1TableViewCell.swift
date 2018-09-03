//
//  Section1TableViewCell.swift
//  Phonebook
//
//  Created by MArko Satlan on 30/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

protocol Section1TableViewCellDelegate: class {
    func buttonTapped(_ tableViewCell: Section1TableViewCell)
}

class Section1TableViewCell: UITableViewCell {
// MARK: - Properties
    let button = UIButton()
    weak var delegate: Section1TableViewCellDelegate?
    let street1TextField = MyTextField()
    let street2TextField = MyTextField()
    let postcodeTextField = MyTextField()
    let cityTextField = MyTextField()
    let countryTextField = MyTextField()
    
// MARK: - Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        button.setTitle("Address", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addSubview(button)
        
        street1TextField.placeholder = "Street"
        street1TextField.setBottomBorder()
        street1TextField.addLeftVerticalSeparator()
        street1TextField.becomeFirstResponder()
        addSubview(street1TextField)
        
        street2TextField.placeholder = "Street"
        street2TextField.setBottomBorder()
        street2TextField.addLeftVerticalSeparator()
        addSubview(street2TextField)
        
        postcodeTextField.placeholder = "Postcode"
        postcodeTextField.setBottomBorder()
        postcodeTextField.addLeftVerticalSeparator()
        addSubview(postcodeTextField)
        
        cityTextField.placeholder = "City"
        cityTextField.setBottomBorder()
        cityTextField.addLeftVerticalSeparator()
        addSubview(cityTextField)
        
        countryTextField.placeholder = "Country"
        countryTextField.setBottomBorder()
        countryTextField.addLeftVerticalSeparator()
        addSubview(countryTextField)
    }
    
    func setConstraints() {
        let labelWidth: CGFloat = 70
        let labelHeight: CGFloat = 30
        
        let horizontalSpacing: CGFloat = 10
        
        let rightColumnWidth = frame.width - 45 - labelWidth - horizontalSpacing
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: topAnchor, constant: 75),
                                     button.leftAnchor.constraint(equalTo: leftAnchor, constant: 45),
                                     button.widthAnchor.constraint(equalToConstant: labelWidth),
                                     button.heightAnchor.constraint(equalToConstant: labelHeight)])
        
        street1TextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([street1TextField.topAnchor.constraint(equalTo: topAnchor),
                                     street1TextField.leftAnchor.constraint(equalTo: button.rightAnchor, constant: horizontalSpacing),
                                     street1TextField.rightAnchor.constraint(equalTo: rightAnchor),
                                     street1TextField.heightAnchor.constraint(equalToConstant: MyTextField.textFieldHeight)])
        
        street2TextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([street2TextField.topAnchor.constraint(equalTo: street1TextField.bottomAnchor, constant: 2),
                                     street2TextField.leftAnchor.constraint(equalTo: button.rightAnchor, constant: horizontalSpacing),
                                     street2TextField.rightAnchor.constraint(equalTo: rightAnchor),
                                     street2TextField.heightAnchor.constraint(equalToConstant: MyTextField.textFieldHeight)])
        
        postcodeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([postcodeTextField.topAnchor.constraint(equalTo: street2TextField.bottomAnchor, constant: 2),
                                     postcodeTextField.leftAnchor.constraint(equalTo: button.rightAnchor, constant: horizontalSpacing),
                                     postcodeTextField.widthAnchor.constraint(equalToConstant: rightColumnWidth / 2),
                                     postcodeTextField.heightAnchor.constraint(equalToConstant: MyTextField.textFieldHeight)])
        
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([cityTextField.topAnchor.constraint(equalTo: street2TextField.bottomAnchor, constant: 2),
                                     cityTextField.leftAnchor.constraint(equalTo: postcodeTextField.rightAnchor, constant: 2),
                                     cityTextField.widthAnchor.constraint(equalToConstant: (rightColumnWidth / 2) - 2),
                                     cityTextField.heightAnchor.constraint(equalToConstant: MyTextField.textFieldHeight)])
        
        countryTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([countryTextField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 2),
                                     countryTextField.leftAnchor.constraint(equalTo: button.rightAnchor, constant: horizontalSpacing),
                                     countryTextField.rightAnchor.constraint(equalTo: rightAnchor),
                                     countryTextField.heightAnchor.constraint(equalToConstant: MyTextField.textFieldHeight)])
        
    }

// MARK: - Action methods
    @objc func buttonTapped(sender: UIButton) {
        delegate?.buttonTapped(self)
    }
}
