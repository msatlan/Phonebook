//
//  NavigationCoordinator.swift
//  Phonebook
//
//  Created by MArko Satlan on 10/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import Foundation
import UIKit

class NavigationCoordinator: ContactsViewControllerDelegate {
// MARK: - Properties
    var navigationController: UINavigationController
    
// MARK: - Init
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

// MARK: - View Controllers Enum
    enum ViewController: Int {
        case contactsViewController         = 0
        case contactDetailsViewController   = 1
        
        var nextVC: UIViewController {
            switch self {
            case .contactsViewController:       return ContactsViewController()
            case .contactDetailsViewController: return ContactDetailsViewController()
            }
        }
    }
    
    func activate(_ nextIndex: Int) {
        guard let nextVC = ViewController(rawValue: nextIndex)?.nextVC else { return }
        navigationController.pushViewController(nextVC, animated: true)
    }
    
    func shouldPushNextViewController(_ viewController: ContactsViewController, contact: Contact, nextIndex: Int) {
        activate(nextIndex)
     
    }
}


