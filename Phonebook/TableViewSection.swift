//
//  TableViewSection.swift
//  Phonebook
//
//  Created by MArko Satlan on 27/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//
import Foundation
import UIKit

class TableViewSection {
// MARK: - Properties
    var name: String
    let headerHeight: Int = 22
    var rowArray: [TableViewRow]

// MARK: - Init
    init(name: String, rowArray: [TableViewRow]) {
        self.name = name
        self.rowArray = rowArray
    }
    
// MARK: - Methods
    func insertNextRow(_ tableView: UITableView, at indexPath: IndexPath, tableViewSection: TableViewSection) {
        rowArray.append(TableViewRow(text: "Phone"))
        tableView.insertRows(at: [IndexPath(row: tableViewSection.rowArray.count - 1, section: indexPath.section - 1)], with: .fade)
    }
    
    func deleteRow(_ tableView: UITableView, at indexPath: IndexPath, tableViewSection: TableViewSection) {
        tableViewSection.rowArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .fade)
    }
}






