//
//  SignInViewController.swift
//  Swifty
//
//  Created by Sergey on 05.05.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

protocol SignInDelegate {
	var user: User? { get set }
}


class SignInViewController: UIViewController, UITextFieldDelegate {
	
	// MARK: - Properties
	
	var delegate: SignInDelegate?
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var doneButton: UIBarButtonItem!
	
	// MARK: - Loading 
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Handle the text field's user input through delegate callbacks
		nameTextField.delegate = self
		
		doneButton.enabled = false
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
		let text = nameTextField.text ?? ""
		doneButton.enabled = !text.isEmpty
	}
	
	// MARK: - Navigation
	
	@IBAction func cancel(sender: UIBarButtonItem) {
		dismissViewControllerAnimated(true, completion: nil)
	}

	override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
		let login = nameTextField.text ?? ""
		let password = passwordTextField.text ?? ""
		delegate?.user = User.getUserWithLogin(login, password: password)
		
		if delegate?.user == nil {
			let alertController = UIAlertController(title: NSLocalizedString("Invalid Login or Password", comment: "The error message"), message: NSLocalizedString("Try again", comment: ""), preferredStyle: .Alert)
			alertController.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
			presentViewController(alertController, animated: true, completion: nil)
			
			return false
		} else {
			return true
		}
	}
}
