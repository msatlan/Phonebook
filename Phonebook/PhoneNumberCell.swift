//
//  ContactNumberCell.swift
//  Phonebook
//
//  Created by MArko Satlan on 20/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

class PhoneNumberCell: UITableViewCell {

// MARK: - Properties
    let button = UIButton()
    let label = UILabel()
    let textField = UITextField()
    let verticalSeparator = UIView()
    
// MARK: - Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
        print("cellov init")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // Configure background color of button when cell is selected 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        button.backgroundColor = UIColor.red
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        button.backgroundColor = UIColor.red
    }

// MARK: - Configure UI / set constraints
    func configureUI() {
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.red
        button.setTitle(" - ", for: .normal)
        contentView.addSubview(button)
       
        contentView.addSubview(label)
        
        verticalSeparator.backgroundColor = UIColor.lightGray
        contentView.addSubview(verticalSeparator)
        
        textField.placeholder = "Phone"
        //textField.keyboardType = .numberPad
        textField.autocorrectionType = .no
        contentView.addSubview(textField)
        textField.becomeFirstResponder()
    }
    
    func setConstraints() {
        let topMargin: CGFloat = 7
        let height: CGFloat = 30
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: topAnchor, constant: topMargin),
                                     button.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
                                     button.widthAnchor.constraint(equalToConstant: 30),
                                     button.heightAnchor.constraint(equalToConstant: height)])
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: topAnchor),
                                     label.leftAnchor.constraint(equalTo: button.rightAnchor, constant: 5),
                                     label.widthAnchor.constraint(equalToConstant: 70),
                                     label.heightAnchor.constraint(equalTo: heightAnchor)])
        
        verticalSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([verticalSeparator.topAnchor.constraint(equalTo: topAnchor),
                                     verticalSeparator.leftAnchor.constraint(equalTo: label.rightAnchor),
                                     verticalSeparator.widthAnchor.constraint(equalToConstant: 1),
                                     verticalSeparator.heightAnchor.constraint(equalTo: heightAnchor)])
 
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textField.topAnchor.constraint(equalTo: topAnchor),
                                     textField.leftAnchor.constraint(equalTo: verticalSeparator.rightAnchor, constant: 10),
                                     textField.rightAnchor.constraint(equalTo: rightAnchor),
                                     textField.heightAnchor.constraint(equalTo: heightAnchor)])
    }
}
