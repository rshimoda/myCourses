//
//  AvailableCoursesTableViewController.swift
//  NextSTEP
//
//  Created by Sergey on 5/25/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class AvailableCoursesTableViewController: UITableViewController {

	// MARK: - Loading
	override func viewDidLoad() {
		tableView.tableFooterView = UIView()
	}
	
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// Return the number of sections
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// Return the number of rows
		return Course.knownCourses.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cellIdentifier = "AvailableCourseCell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AvailableCourseCell
		
		let course = Course.knownCourses[indexPath.row]
		
		cell.courseName.text = course.name
		cell.promo.text = "\(course.sigature)"
		
		return cell
	}

	
}
