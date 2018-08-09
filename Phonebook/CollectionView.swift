//
//  CollectionView.swift
//  Phonebook
//
//  Created by MArko Satlan on 09/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView {
    
    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: CollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
