//
//  CollectionReusableView.swift
//  Phonebook
//
//  Created by MArko Satlan on 13/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
// MARK: - Properties
    let label = UILabel()
    
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Configure UI / set constraints
    private func configureUI() {
        backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        label.font = UIFont(name: "Avenir-BlackObliqe", size: 20)
        
        addSubview(label)
    }
    
    private func setConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([label.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     label.leftAnchor.constraint(equalTo: leftAnchor),
                                     label.rightAnchor.constraint(equalTo: rightAnchor),
                                     label.topAnchor.constraint(equalTo: topAnchor)])
    }
    
}
