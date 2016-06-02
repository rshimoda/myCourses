//
//  AddPublicationViewController.swift
//  NextSTEP
//
//  Created by Sergey on 6/2/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class AddPublicationViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

	// MARK: - Properties
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var outlineTextField: UITextField!
	@IBOutlet weak var descriptionTextView: UITextView!
	
	@IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
	
	var imagePicker = UIImagePickerController()
	
	var publication: Publication?
	
	//MARK: - Initialization
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		outlineTextField.delegate = self
		
		imagePicker.delegate = self
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
		doneBarButtonItem.enabled = !(outlineTextField.text?.isEmpty)!
	}
	
	// MARK: - UIImagePickerControllerDelegate Methods
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
			imageView.contentMode = .ScaleAspectFit
			imageView.image = pickedImage
		}
		
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	// MARK: - Actions
	
	@IBAction func addAnImage(sender: AnyObject) {
		imagePicker.allowsEditing = false
		imagePicker.sourceType = .PhotoLibrary
		
		presentViewController(imagePicker, animated: true, completion: nil)
	}
	
	@IBAction func cancel(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	// MARK: - Navigation
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		publication = Publication(name: outlineTextField.text!, material: descriptionTextView.text ?? "")
		publication?.image = imageView.image
	}
}
