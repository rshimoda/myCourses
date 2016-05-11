//
//  SignInViewController.swift
//  Swifty
//
//  Created by Sergey on 05.05.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit


protocol SignInDataSource {
	func setUser(name: String, password: String) -> Bool
}


class SignInViewController: UIViewController, UITextFieldDelegate {

	// MARK: - Properties
	
	private var delegate: SignInDataSource?
	var user: User?
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var doneButton: UIBarButtonItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Handle the text field's user input through delegate callbacks
		nameTextField.delegate = self
		
		checkValidMailAndPassword()
	}
	
	
	// MARK: - UITextFieldDelegate
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		//Hide the keyboard
		textField.resignFirstResponder()
		
		return true
	}
	
	func textFieldDidBeginEditing(textField: UITextField) {
		// Disable Save button while editing
		doneButton.enabled = false
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		checkValidMailAndPassword()
		
		
	}
	
	func checkValidMailAndPassword() {
		let text = nameTextField.text ?? ""
		doneButton.enabled = !text.isEmpty
	}
	
	// MARK: - Navigation
	
	@IBAction func cancel(sender: UIBarButtonItem) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if doneButton == sender as! UIBarButtonItem {
			let email = nameTextField.text ?? ""
			let password = passwordTextField.text ?? ""
			
			user = User.getUserIfExists(email, password: password)
		}
	}
	
	// MARK: - Actions
	
	@IBAction func finishLogging(sender: UIBarButtonItem) {
		delegate?.setUser(nameTextField.description, password: passwordTextField.description)
		navigationController?.popViewControllerAnimated(true)
	}
}
