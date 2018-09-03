//
//  ContactsViewModel.swift
//  Phonebook
//
//  Created by MArko Satlan on 12/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

class ContactsViewModel {
// MARK: - Properties
    var contactsArray: [Contact] = []
    var sectionsArray: [Section] = []
    var sectionNames: [String] = []
    
// MARK: - Init
    init() {
    }
    
    func makeSections() {
        sectionsArray.removeAll()
        sectionNames.removeAll()
        
        let sortedArray = contactsArray.sorted { $0.lastName < $1.lastName }
        var currentSection: Section? = nil
        var currentSectionName = ""
        
        for contact in sortedArray {
            if currentSectionName != String(contact.lastName.prefix(1)) {
                currentSectionName = String(contact.lastName.prefix(1))
                currentSection = Section(name: currentSectionName)
                sectionsArray.append(currentSection!)
                sectionNames.append(currentSectionName)
            }
            if let section = currentSection {
                section.addContact(contact: contact)
            }
        }
    }

    func numberOfItems(inSection section: Int) -> Int {
        return sectionsArray[section].contactsArray.count
    }
    
    func contact(at indexPath: IndexPath) -> Contact {
        return sectionsArray[indexPath.section].contactsArray[indexPath.row]
    }
}

// Contact se ne smije spominjati u view controlleru!! -> MVVM
// view model ne smije znat za vju
// init u view controlleru
