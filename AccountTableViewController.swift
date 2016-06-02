//
//  AccountTableViewController.swift
//  NextSTEP
//
//  Created by Sergey on 5/25/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

protocol AccountsDataSource {
	var user: User? { get set }
}

protocol SignInDelegate {
	var user: User? { get set }
}

class AccountTableViewController: UITableViewController, UITextFieldDelegate {
	
	// MARK: - Properties
	@IBOutlet weak var firstName: UILabel!
	@IBOutlet weak var secondName: UILabel!
	@IBOutlet weak var userImage: UIImageView!
	@IBOutlet weak var userLogin: UILabel!
	@IBOutlet weak var signOutLabel: UILabel!
	@IBOutlet weak var usersInitials: UILabel!
	@IBOutlet weak var signInLabel: UILabel!
	@IBOutlet weak var signOutTableViewCell: UITableViewCell!
	@IBOutlet weak var signInTableViewCell: UITableViewCell!
	@IBOutlet weak var registerTableViewCell: UITableViewCell!
	@IBOutlet weak var infoUserTableViewCell: UITableViewCell!
	@IBOutlet weak var authorizationFields: UIStackView!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	weak var user: User? {
		didSet {
			updateUI()
		}
	}
	
	var delegate: AccountsDataSource?
	
	// MARK: - Loading
	
	override func viewDidLoad() {
		emailTextField.delegate = self
		user = delegate?.user
	}
	
	// MARK: - Navigation
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let dvc = segue.destinationViewController as? CourseTableViewController {
			if user != nil && !signOutLabel.enabled {
				dvc.user = user
			}
		}
	}
	
	// MARK: - UITextFieldDelegate
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		//Hide the keyboard
		textField.resignFirstResponder()
		
		return true
	}
	
	func textFieldDidBeginEditing(textField: UITextField) {
		// Disable Save button while editing
		signInLabel.enabled = false
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		let text = emailTextField.text ?? ""
		signInLabel.enabled = !text.isEmpty
	}
	
	// MARK: - Navigation
	
	@IBAction func cancel(sender: UIBarButtonItem) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	// MARK: - Actions
	
	private func updateUI() {
		if user == nil {
			signOutTableViewCell.hidden = true
			
			signInTableViewCell.hidden = false
			registerTableViewCell.hidden = false
			
			usersInitials.text = " "
			userLogin.text = " "
			
			authorizationFields.hidden = false
		} else {
			signOutTableViewCell.hidden = false
			
			signInTableViewCell.hidden = true
			registerTableViewCell.hidden = true
			
			firstName.text = user?.firstName ?? " "
			secondName.text = user?.secondName ?? " "
			userImage.image = user?.image
			userLogin.text = user?.login

			let firstNameLetter = user?.firstName[(user?.firstName.startIndex)!] ?? " "
			let secondNameLetter = user?.secondName[(user?.secondName.startIndex)!] ?? " "
			usersInitials.text = String([ firstNameLetter, secondNameLetter ])
			
			authorizationFields.hidden = true
		}
	}
}
