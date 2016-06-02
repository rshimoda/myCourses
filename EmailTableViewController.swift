//
//  EmailTableViewController.swift
//  NextSTEP
//
//  Created by Sergey on 5/26/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class EmailTableViewController: UITableViewController, UITextFieldDelegate {
	
	// MARK: - Properties
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var repeatedPasswordTextField: UITextField!
	@IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
	
	var user: User?

	// MARK: - Loading
	
	override func viewDidLoad() {
		self.tableView.tableFooterView = UIView(frame: CGRectZero)
		
		emailTextField.delegate = self
		passwordTextField.delegate = self
		repeatedPasswordTextField.delegate = self
	}
	
	// MARK: - UITextFieldDelegate
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		//Hide the keyboard
		textField.resignFirstResponder()
		
		return true
	}
	
	func textFieldDidBeginEditing(textField: UITextField) {
		// Disable Save button while editing
		doneBarButtonItem.enabled = false
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		let emailText = emailTextField.text ?? ""
		let passwordText = passwordTextField.text ?? ""
		let repeatedPasswordText = repeatedPasswordTextField.text ?? ""
		
		if !emailText.isEmpty && passwordText == repeatedPasswordText && !passwordText.isEmpty {
			doneBarButtonItem.enabled = true
		} else {
			doneBarButtonItem.enabled = false
		}
	}
	
	// MARK: - Navigation
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		user?.login = emailTextField.text!
		user?.password = passwordTextField.text!
		
		User.addUser(user!)
		
		print("prepare for segue")
	}
}
