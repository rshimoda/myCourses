//
//  NameTableViewController.swift
//  NextSTEP
//
//  Created by Sergey on 5/26/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class NameTableViewController: UITableViewController, UITextFieldDelegate {

	// MARK: - Properties
	@IBOutlet weak var firstName: UITextField!
	@IBOutlet weak var lastName: UITextField!
	@IBOutlet weak var slider: UISwitch!
	@IBOutlet weak var nextBarButtonItem: UIBarButtonItem!
	
	
	// MARK: - Loading
	
	override func viewDidLoad() {
		self.tableView.tableFooterView = UIView(frame: CGRectZero)
		
		firstName.delegate = self
		lastName.delegate = self
	}
	
	// MARK: - UITextFieldDelegate
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		//Hide the keyboard
		textField.resignFirstResponder()
		
		return true
	}
	
	func textFieldDidBeginEditing(textField: UITextField) {
		// Disable Save button while editing
		nextBarButtonItem.enabled = false
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		let fName = firstName.text ?? ""
		let lName = lastName.text ?? ""
		nextBarButtonItem.enabled = !(fName.isEmpty || lName.isEmpty)
	}
	
	// MARK: - Navigation
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let dvc = segue.destinationViewController as? EmailTableViewController {
			dvc.user = User(login: "", password: "", firstName: firstName.text!, secondName: lastName.text!)
		}
	}
}
