//
//  NewContactViewController.swift
//  Phonebook
//
//  Created by MArko Satlan on 16/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

class NewContactViewController: UIViewController {
// MARK: - Properties
    var onDidSelectCancel: (() -> ())?
    private let tableView = UITableView(frame: CGRect.zero)
    private var cellText: [String] = ["Mobile:", "Home:", "Work:", "Private:"]
    private var rowArray: [Int] = []
    private var activeTextField: UITextField?
    
// MARK: - Constants
    private let cellIdentifier = "Cell"
    private let phoneNumberCell = "PhoneNumberCell"
    private let addNumberCell = "AddNumberCell"

// MARK: - Methods
    // View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "New Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        
        view.backgroundColor = UIColor.white
        
        configureTableView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    // TableView setup
    func configureTableView() {
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(PhoneNumberCell.self, forCellReuseIdentifier: phoneNumberCell)
        tableView.register(AddNumberCell.self, forCellReuseIdentifier: addNumberCell)
        view.addSubview(tableView)
        
        // Set constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: guide.topAnchor),
                                     tableView.leftAnchor.constraint(equalTo: guide.leftAnchor),
                                     tableView.rightAnchor.constraint(equalTo: guide.rightAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)])
    }
    
    // Action methods
    @objc private func cancelTapped() {
        onDidSelectCancel?()
    }
    
    @objc private func doneTapped() {
        print("done")
    }

    // Keyboard observer
    @objc func keyboardDidShow(notification: NSNotification) {
        print("key did show")
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           let activeField = activeTextField {
                tableView.setContentOffset(CGPoint(x: 0, y: activeField.superview!.superview!.frame.origin.y - keyboardSize.height - 22), animated: true)
            }
        }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("key will hide")
    }
    /*
    func nextItem(tableView: UITableView) -> String {
        currentIndex += 1
        let items: [String] = ["Mobile:", "Home:", "Private:", "Work:"]

        //tableView.reloadData()
        return items[currentIndex]
    }*/
}

extension NewContactViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "User Info"
        case 1: return "Address"
        case 2: return "Phone Number"
        case 3: return ""
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 3
        case 1: return 5
        case 2: return rowArray.count
        case 3: return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: addNumberCell, for: indexPath) as! AddNumberCell
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: phoneNumberCell, for: indexPath) as! PhoneNumberCell
            let text = cellText[indexPath.row]
            cell.label.text = text
            cell.selectionStyle = .none
            cell.textField.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            cell.textLabel?.text = "cell"
            return cell
        }
    }
}

extension NewContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            if rowArray.count <= 3 {
            rowArray.append(1)
            tableView.insertRows(at: [IndexPath(row: rowArray.count - 1, section: 2)], with: .fade)
            } else {
            print("ne moze vise")
            }
        tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension NewContactViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        activeTextField = nil
        return true
    }
}

