//
//  CourseDescriptionViewController.swift
//  NextSTEP
//
//  Created by Sergey on 5/27/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class CourseDescriptionViewController: UITableViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
	// MARK: - Properties
	
	@IBOutlet weak var courseNameLabel: UILabel!
	@IBOutlet weak var universityLabel: UILabel!
	@IBOutlet weak var courseImage: UIImageView!
	
	@IBOutlet weak var url: UITextField!
	@IBOutlet weak var overview: UITextField!
	@IBOutlet weak var promo: UITextField!

	@IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
	@IBOutlet weak var refreshBarButtonItem: UIBarButtonItem!
	
	var imagePicker = UIImagePickerController()
	
	var course: Course?
	
	// MARK: - Loading
	
	override func viewDidLoad() {
		self.tableView.tableFooterView = UIView(frame: CGRectZero)
		
		url.delegate = self
		overview.delegate = self
		promo.delegate = self
		
		imagePicker.delegate = self
		
		courseNameLabel.text = course?.name
		universityLabel.text = course?.university
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
		let overviewText = overview.text ?? ""
		let promoText = promo.text ?? ""
		let urlText = url.text ?? ""
		doneBarButtonItem.enabled = !(overviewText.isEmpty || promoText.isEmpty)
		refreshBarButtonItem.enabled = !urlText.isEmpty
		
	}
	
	// MARK: - UIImagePickerControllerDelegate Methods
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
			courseImage.contentMode = .ScaleAspectFit
			courseImage.image = pickedImage
		}
		
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	// MARK: - Navigation
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		course?.courseImage = courseImage.image
		course?.sigature = promo.text!
		course?.courseDescription = overview.text!
		course?.created = NSDate()
		course?.updated = NSDate()
	}
	
	// MARK: - Actions
	
	@IBAction func addAnImage(sender: AnyObject) {
		imagePicker.allowsEditing = false
		imagePicker.sourceType = .PhotoLibrary
		
		presentViewController(imagePicker, animated: true, completion: nil)
	}
	
	@IBAction func refresh(sender: UIBarButtonItem) {
		if let newURL = NSURL(string: url.text ?? "") {
			if let data = NSData(contentsOfURL: newURL) {
				if let newImage = UIImage(data: data) {
					courseImage.image = newImage
				}
			}
		}
	}
}
