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

class AccountTableViewController: UITableViewController, SignInDelegate {
	
	// MARK: - Properties
	@IBOutlet weak var firstName: UILabel!
	@IBOutlet weak var secondName: UILabel!
	@IBOutlet weak var userImage: UIImageView!
	@IBOutlet weak var signOutLabel: UILabel!
	@IBOutlet weak var usersInitials: UILabel!
	@IBOutlet weak var signOutTableViewCell: UITableViewCell!
	@IBOutlet weak var infoUserTableViewCell: UITableViewCell!
	
	weak var user: User? {
		didSet {
			updateUI()
		}
	}
	
	var delegate: AccountsDataSource?
	
	// MARK: - Loading
	
	override func viewDidLoad() {
		user = delegate?.user
	}
	
	// MARK: - Navigation
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let dvc = segue.destinationViewController as? SignInViewController {
			dvc.delegate = self
		}
	}
	
	override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
		if identifier == "Sign In" || user == nil {
			return true
		}
		
		return signOutLabel.enabled
	}
	
	@IBAction func unwindToAccounts(sender: UIStoryboardSegue) {
		if let svc = sender.sourceViewController as? SignInViewController {
			svc.delegate = self
		}
		
		if sender.sourceViewController is SignInViewController {
			if user == nil {
				let alertController = UIAlertController(title: "Autorization Failed", message: "Try to sign up again", preferredStyle: .Alert)
				alertController.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
				presentViewController(alertController, animated: true, completion: nil)
			}
		}
	}
	
	// MARK: - Actions
	
	private func updateUI() {
		if user == nil {
			signOutLabel.enabled = false
			signOutTableViewCell.selectionStyle = .None
			usersInitials.text = " "
		} else {
			signOutLabel.enabled = true
			signOutTableViewCell.selectionStyle = .Default
			
			firstName.text = user?.firstName ?? " "
			secondName.text = user?.secondName ?? " "
			userImage.image = user?.image

			let firstNameLetter = user?.firstName[(user?.firstName.startIndex)!] ?? " "
			let secondNameLetter = user?.secondName[(user?.secondName.startIndex)!] ?? " "
			usersInitials.text = String([ firstNameLetter, secondNameLetter ])
		}
	}
}
