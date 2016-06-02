//
//  AvailableCoursesTableViewController.swift
//  NextSTEP
//
//  Created by Sergey on 5/25/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class AvailableCoursesTableViewController: UITableViewController {

	// MARK: - Properties
	@IBOutlet weak var addBarButtonItem: UIBarButtonItem!
	
	// MARK: - Loading
	override func viewDidLoad() {
		tableView.tableFooterView = UIView()
	}
	
	override func viewDidAppear(animated: Bool) {
		let nvc = tabBarController?.viewControllers?.first as! UINavigationController
		let cvc = nvc.viewControllers.first! as! CourseTableViewController
		if cvc.user != nil {
			addBarButtonItem.enabled  = true
		} else {
			addBarButtonItem.enabled = false
		}
	}
	
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// Return the number of sections
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// Return the number of rows
		return knownCourses.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cellIdentifier = "AvailableCourseCell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AvailableCourseCell
		
		let course = knownCourses[indexPath.row]
		
		cell.courseName.text = course.name
		cell.promo.text = "(\(course.sigature))"
		
		return cell
	}
	
	// MARK: - Navigation
	
	@IBAction func addCourseAndUnwindToAvailableCourseList(sender: UIStoryboardSegue) {
		let svc = sender.sourceViewController as! CourseDescriptionViewController
		
		knownCourses += [svc.course!]
		saveCourses()
		
		self.tableView.reloadData()
	}
	
	// MARK: - NSCoding
	
	func saveCourses() {
		let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(knownCourses, toFile: Course.ArchiveURL.path!)
		if !isSuccessfulSave {
			print("Failed to save courses...")
		}
	}
}
