//
//  CollectionViewFlowLayout.swift
//  Phonebook
//
//  Created by MArko Satlan on 08/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

class CollectionViewFlowLayout: UICollectionViewFlowLayout {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init() {
        super.init()
        
        setUp()
    }
    
    func setUp() {
        sectionInset = UIEdgeInsetsMake(20, 35, 20, 35)
        minimumLineSpacing = 30
    }
    
   
}
