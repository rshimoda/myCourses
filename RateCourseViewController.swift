//
//  RateCourseViewController.swift
//  NextSTEP
//
//  Created by Sergey on 6/2/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class RateCourseViewController: UITableViewController {
	
	
	@IBOutlet weak var ratingControl: RatingControl!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func changeRating(sender: UIStepper) {
		ratingControl.rating = Int(sender.value)
	}
	
	@IBAction func cancel(sender: UIBarButtonItem) {
		dismissViewControllerAnimated(true, completion: nil)
	}
}
