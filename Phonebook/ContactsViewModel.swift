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
        let c1 = Contact()
        c1.firstName = "mirko"
        c1.lastName = "prijatelj od slavka"
        
        let c2 = Contact()
        c2.firstName = "slavko"
        c2.lastName = "prijatelj od mirka"
        
        let c3 = Contact()
        c3.firstName = "betmen"
        c3.lastName = "sismis"
        
        let c4 = Contact()
        c4.firstName = "jovo"
        c4.lastName = "binsr"
        
        let c5 = Contact()
        c5.firstName = "sikaka"
        c5.lastName = "sismis"
        
        let c6 = Contact()
        c6.firstName = "raduljica"
        c6.lastName = "binsr"
        
        let c7 = Contact()
        c7.firstName = "miki"
        c7.lastName = "kerusina"
        
        contactsArray.append(c1)
        contactsArray.append(c2)
        contactsArray.append(c3)
        contactsArray.append(c4)
        contactsArray.append(c5)
        contactsArray.append(c6)
        contactsArray.append(c7)
        
        makeSections()
    }
    
    private func makeSections() {
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
