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
    
    private var deletedRowsArray: [TableViewRow] = []
    private var currentRowIndex = -1
    
    private let section2Row0 = TableViewRow(text: "Mobile:")
    private let section2Row1 = TableViewRow(text: "Home:")
    private let section2Row2 = TableViewRow(text: "Work:")
    private let section2Row3 = TableViewRow(text: "Private:")
    
// MARK: - Init
    init(name: String, rowArray: [TableViewRow]) {
        self.name = name
        self.rowArray = rowArray
    }
    
// MARK: - Methods
    func insertNextRow(_ tableView: UITableView, at indexPath: IndexPath, tableViewSection: TableViewSection) {
        if deletedRowsArray.isEmpty {
            currentRowIndex += 1
            
            var rowsToAdd: [TableViewRow] = [section2Row0, section2Row1, section2Row2, section2Row3]
            
            if rowArray.count <= rowsToAdd.count - 1 {
                let nextRow: TableViewRow = rowsToAdd[currentRowIndex]
                rowArray.append(nextRow)
                tableView.insertRows(at: [IndexPath(row: tableViewSection.rowArray.count - 1, section: indexPath.section - 1)], with: .fade)
            }
        } else {
            rowArray.append(deletedRowsArray.last!)
            deletedRowsArray.removeLast()
            tableView.insertRows(at: [IndexPath(row: tableViewSection.rowArray.count - 1, section: indexPath.section - 1)], with: .fade)
        }
    }
    
    func deleteRow(_ tableView: UITableView, at indexPath: IndexPath, tableViewSection: TableViewSection) {
        let rowToDelete = tableViewSection.rowArray[indexPath.row]
        tableViewSection.rowArray.remove(at: indexPath.row)
        deletedRowsArray.append(rowToDelete)
        print(deletedRowsArray.count)
        tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .fade)
    }
}






