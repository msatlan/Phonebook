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
    let viewModel: NewContactViewModel
    var contact: Contact?
    
    var onDidSelectCancel: (() -> ())?
    var onDidSelectDone: (() -> ())?
    
    private let tableView = UITableView(frame: CGRect.zero)
    private var guide: UILayoutGuide!
    private var bottomConstraint: NSLayoutConstraint!
    private let contactToAdd = Contact()
    
//MARK: - Init
    init(viewModel: NewContactViewModel ) {
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
    private let section1Cell = "Section1Cell"

// MARK: - Methods
    // View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
         guide = view.safeAreaLayoutGuide
        
        navigationItem.title = "New Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        view.backgroundColor = UIColor.white
        
        configureTableView()
        
        // Set tableView constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        bottomConstraint = tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: guide.topAnchor),
                                     tableView.leftAnchor.constraint(equalTo: guide.leftAnchor),
                                     tableView.rightAnchor.constraint(equalTo: guide.rightAnchor),
                                     bottomConstraint])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        if let textField = tableView.viewWithTag(111) as? UITextField {
            textField.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
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
        tableView.register(Section1TableViewCell.self, forCellReuseIdentifier: section1Cell)
        tableView.setEditing(true, animated: true)
        tableView.allowsSelectionDuringEditing = true
        view.addSubview(tableView)
        
    }
    
    // Action methods
    @objc private func cancelTapped() {
        onDidSelectCancel?()
    }
    
    @objc private func doneTapped() {
        onDidSelectDone?()
    }

    // Keyboard observer
    @objc func keyboardWillShow(notification: NSNotification) {
        //print("keyboard will show")
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomConstraint.constant = -1 * keyboardSize.height
            view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        //print("keyboard will hide")
        bottomConstraint.constant = 0
        //print(view.frame.height, guide.layoutFrame.height)
        view.layoutIfNeeded()
    }

    // Handle Done button
    private func toggleDoneButton() {
        /*
        print(userDidEnterData)
        if userDidEnterData {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }*/
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
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: section0Cell, for: indexPath) as! Section0TableViewCell
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: section1Cell, for: indexPath) as! Section1TableViewCell
            cell.delegate = self
            cell.street1TextField.delegate = self
            cell.street2TextField.delegate = self
            cell.postcodeTextField.delegate = self
            cell.cityTextField.delegate = self
            cell.countryTextField.delegate = self
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            cell.textLabel?.text = "Add Address"
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: customCell, for: indexPath) as! CustomTableViewCell
            cell.button.setTitle(viewModel.textForRow(at: indexPath), for: .normal)
            cell.button.setTitleColor(UIColor.blue, for: .normal)
            cell.button.contentHorizontalAlignment = .left
            cell.selectionStyle = .none
            cell.textField.delegate = self
            cell.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            cell.textLabel?.text = "Add Number"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            cell.textLabel?.text = ""
            return cell
        }
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return viewModel.editingStyleForSection(indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 135
        } else if indexPath.section == 1 {
            return 179
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
        switch indexPath.section {
        case 2, 4:
            viewModel.insertRows(tableView, at: indexPath)
        default:
            print(indexPath.row)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
}

extension NewContactViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //activeTextField = textField
        //activeTextField?.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
 
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        print(txtAfterUpdate)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
    }
 */
}

extension NewContactViewController: CustomTableViewCellDelegate {
    func buttonTapped(_ tableViewCell: CustomTableViewCell) {
        let alert = UIAlertController(title: "Phone number description",
                                      message: "Add a description",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            guard let textField = alert.textFields?.first,
                  let description = textField.text else { return }
            tableViewCell.button.setTitle(description, for: .normal)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
}

extension NewContactViewController: Section1TableViewCellDelegate {
    func buttonTapped(_ tableViewCell: Section1TableViewCell) {
        let alert = UIAlertController(title: "Address description",
                                      message: "Add a description",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            guard let textField = alert.textFields?.first,
                let description = textField.text else { return }
                tableViewCell.button.setTitle(description, for: .normal)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension NewContactViewController: Section0TableViewCellDelagate {
    func lastNameTextFieldDidEndEditing(_ tableViewCell: Section0TableViewCell, text: String) {
        contactToAdd.lastName = text
    }
    
    func companyTextFieldDidEndEditing(_ tableViewCell: Section0TableViewCell, text: String) {
        contactToAdd.company = text
    }
    
    func firstNameTextFieldDidEndEditing(_ tableViewCell: Section0TableViewCell, text: String) {
        contactToAdd.firstName = text
        print(contactToAdd.firstName)
    }
}









