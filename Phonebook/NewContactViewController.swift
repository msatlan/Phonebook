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
    let viewModel: TableViewViewModel
    
    var onDidSelectCancel: (() -> ())?
    private let tableView = UITableView(frame: CGRect.zero)
    private var activeTextField: UITextField?
    private var userDidEnterData = false
    private var keyboardIsActive = false

//MARK: - Init
    init(viewModel: TableViewViewModel ) {
        print("init")
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Constants
    private let cellIdentifier = "Cell"
    private let customCell = "CustomCell"
    private let section0Cell = "Section0Cell"

// MARK: - Methods
    // View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
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
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: customCell)
        tableView.register(Section0TableViewCell.self, forCellReuseIdentifier: section0Cell)
        tableView.setEditing(true, animated: true)
        tableView.allowsSelectionDuringEditing = true
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
        activeTextField!.resignFirstResponder()
        activeTextField = nil
    }

    // Keyboard observer
    @objc func keyboardDidShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           let activeField = activeTextField {
            let visibleRect = CGRect(x: 0,
                                     y: 0,
                                     width: view.frame.width,
                                     height: view.frame.height - keyboardSize.height)
            
            // visible += tableview section headers? safe area?
            
            if visibleRect.contains(activeField.frame.origin) {
                //print(visibleRect.height, activeField.superview!.superview!.frame.origin)
            } else {
                tableView.setContentOffset(CGPoint(x: 0, y: activeField.superview!.superview!.frame.origin.y - keyboardSize.height - 22), animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("key will hide")
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        keyboardIsActive = false
    }

    // Handle Done button
    private func toggleDoneButton() {
        print(userDidEnterData)
        if userDidEnterData {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}

extension NewContactViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.sectionHeaderHeight()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionHeaderTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: customCell, for: indexPath) as! CustomTableViewCell
            cell.label.text = "Add Number"
            cell.verticalSeparator.removeFromSuperview()
            cell.textField.removeFromSuperview()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: customCell, for: indexPath) as! CustomTableViewCell
            cell.label.text = viewModel.textForRow(at: indexPath)
            cell.selectionStyle = .none
            cell.textField.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: customCell, for: indexPath) as! CustomTableViewCell
            cell.label.text = "Add Address"
            cell.verticalSeparator.removeFromSuperview()
            cell.textField.removeFromSuperview()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: customCell, for: indexPath) as! CustomTableViewCell
            cell.label.text = viewModel.textForRow(at: indexPath)
            cell.selectionStyle = .none
            cell.textField.delegate = self
            return cell
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: section0Cell, for: indexPath) as! Section0TableViewCell
            return cell
            /*
            if indexPath.row == 0 {
                cell.label.text = viewModel.textForRow(at: indexPath)
                cell.selectionStyle = .none
                cell.textField.delegate = self
                cell.textField.keyboardType = .default
                activeTextField = cell.textField
                activeTextField?.becomeFirstResponder()
                NSLayoutConstraint.activate([cell.label.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 15)])
                
                return cell
            } else {
                cell.label.text = viewModel.textForRow(at: indexPath)
                cell.selectionStyle = .none
                cell.textField.delegate = self
                cell.textField.keyboardType = .default
                NSLayoutConstraint.activate([cell.label.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 15)])
                return cell
            }*/
        default: break
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return viewModel.editingStyleForSection(indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 132
        } else {
            return UITableViewAutomaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteRows(tableView, at: indexPath)
        } else if editingStyle == .insert {
            viewModel.insertRows(tableView, at: indexPath)
        }
    }
}

extension NewContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 || indexPath.section == 4 {
            viewModel.insertRows(tableView, at: indexPath)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            print(indexPath.row)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let activeField = activeTextField {
            activeField.resignFirstResponder()
        }
    }
}

extension NewContactViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        activeTextField?.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        activeTextField = nil
        return true
    }
    
    @objc func textDidChange(textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            userDidEnterData = true
            toggleDoneButton()
        } else {
            userDidEnterData = false
            toggleDoneButton()
        }
    }
}










