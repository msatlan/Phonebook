//
//  ContactDetailsViewController.swift
//  Phonebook
//
//  Created by MArko Satlan on 10/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {

// MARK: - Properties
    var contact: Contact?
    static let viewControllerIndex = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blue
        
        print(contact?.firstName)
    }


}
