//
//  AddNumberCell.swift
//  Phonebook
//
//  Created by MArko Satlan on 21/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

class AddNumberCell: UITableViewCell {

    // MARK: - Properties
    let button = UIButton()
    let label = UILabel()
    
    // MARK: - Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Configure background color of button when cell is selected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        button.backgroundColor = UIColor.green
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        button.backgroundColor = UIColor.green
    }
    
    // MARK: - Configure UI / set constraints
    func configureUI() {
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.red
        button.setTitle(" + ", for: .normal)
        contentView.addSubview(button)
        
        label.text = "Add number"
        contentView.addSubview(label)
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
                                     label.widthAnchor.constraint(equalToConstant: 100),
                                     label.heightAnchor.constraint(equalTo: heightAnchor)])
    }

}
