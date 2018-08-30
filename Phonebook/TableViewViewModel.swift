//
//  TableViewSectionViewModel.swift
//  Phonebook
//
//  Created by MArko Satlan on 27/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//
import UIKit

class TableViewViewModel {
// MARK: - Properties
    var sectionsArray: [TableViewSection] = []
    
// MARK: - Init
    init() {
        let section0 = TableViewSection(name: "User Info", rowArray: [TableViewRow(text: "")])
        
        let section1 = TableViewSection(name: "Address", rowArray: [])
        let section2 = TableViewSection(name: "", rowArray: [TableViewRow(text: "")])
        
        let section3 = TableViewSection(name: "Phone Number", rowArray: [])
        let section4 = TableViewSection(name: "", rowArray: [TableViewRow(text: "")])
        
        sectionsArray.append(section0)
        sectionsArray.append(section1)
        sectionsArray.append(section2)
        sectionsArray.append(section3)
        sectionsArray.append(section4)
    }

    func sectionHeaderHeight() -> CGFloat {
        return CGFloat((sectionsArray.first?.headerHeight)!)
    }
    
    func sectionHeaderTitle(for section: Int) -> String {
        return sectionsArray[section].name
    }
    
    func numberOfRows(in section: Int) -> Int {
        return sectionsArray[section].rowArray.count
    }

    func textForRow(at indexPath: IndexPath) -> String {
        return sectionsArray[indexPath.section].rowArray[indexPath.row].text
    }
    
    func insertRows(_ tableView: UITableView, at indexPath: IndexPath) {
        let tableViewSection = sectionsArray[indexPath.section - 1]
        tableViewSection.insertNextRow(tableView, at: indexPath, tableViewSection: tableViewSection)
    }
    
    func deleteRows(_ tableView: UITableView, at indexPath: IndexPath) {
        let tableViewSection = sectionsArray[indexPath.section]
        tableViewSection.deleteRow(tableView, at: indexPath, tableViewSection: tableViewSection)
    }
    
    func editingStyleForSection(_ indexPath: IndexPath) -> UITableViewCellEditingStyle {
        switch indexPath.section {
        case 2, 4: return .insert
        case 1, 3: return .delete
        default: break
        }
        return .none
    }
    
    
}
















// "Mobile:", "Home:", "Work:", "Private:"
