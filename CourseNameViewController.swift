//
//  CourseNameViewController.swift
//  NextSTEP
//
//  Created by Sergey on 5/27/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class CourseNameViewController: UITableViewController, UITextFieldDelegate {

	// MARK: - Properties
	@IBOutlet weak var courseName: UITextField!
	@IBOutlet weak var university: UITextField!
	@IBOutlet weak var instructor: UITextField!
	@IBOutlet weak var duration: UITextField!
	@IBOutlet weak var nextBarButtonItem: UIBarButtonItem!
	
	// MARK: - Loading
	
	override func viewDidLoad() {
		self.tableView.tableFooterView = UIView(frame: CGRectZero)
		
		let nvc = tabBarController?.viewControllers?.first as! UINavigationController
		let tvc = nvc.viewControllers.first! as! CourseTableViewController
		
		instructor.text = "\((tvc.user?.firstName)!) \((tvc.user?.secondName)!)"
		
		courseName.delegate = self
		university.delegate = self
		duration.delegate = self
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
		let cName = courseName.text ?? ""
		let uName = university.text ?? ""
		let dText = duration.text ?? ""
		nextBarButtonItem.enabled = !(cName.isEmpty || uName.isEmpty || dText.isEmpty)
	}
	
	// MARK: - Navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let dvc = segue.destinationViewController as? CourseDescriptionViewController {
			let newCourse = Course(name: courseName.text!, university: university.text!, promo: "")
			newCourse.duration = duration.text!
			newCourse.instructor = ((tabBarController?.viewControllers?.first as! UINavigationController).viewControllers.first! as! CourseTableViewController).user!
			
			dvc.course = newCourse
		}
	}
	
}
