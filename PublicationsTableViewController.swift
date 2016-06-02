//
//  PublicationsTableViewController.swift
//  NextSTEP
//
//  Created by Sergey on 6/2/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class PublicationsTableViewController: UITableViewController {

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
		return ((navigationController?.viewControllers.first as? CourseDashboardViewController)!.course?.publications.count) ?? 0
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cellIdentifier = "PublicationTableViewCell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PublicationTableViewCell
		
		let publication = (navigationController?.viewControllers.first as? CourseDashboardViewController)?.course?.publications[indexPath.row]
		
		cell.publication.text = publication?.name
		
		return cell
	}
	
	@IBAction func addPublicationAndUnwindToPublicationsList(sender: UIStoryboardSegue) {
		let svc = sender.sourceViewController as! AddPublicationViewController
		
		let dvc = (navigationController?.viewControllers.first as? CourseDashboardViewController)
		
		knownCourses[knownCourses.indexOf(Course.getCourseBySignature((dvc?.course?.sigature)!)!)!].publications += [svc.publication!]
		knownCourses[knownCourses.indexOf(Course.getCourseBySignature((dvc?.course?.sigature)!)!)!].outline += ["\((dvc!.course?.outline.count)! + 1) \(svc.publication!.name)"]
		
		dvc?.course = Course.getCourseBySignature((dvc?.course?.sigature)!)
		
		User.updateCourseToAllUsers(Course.getCourseBySignature((dvc?.course?.sigature)!)!)
				
		saveUsers()
		saveCourses()
		
		tableView.reloadData()
	}
	
	// MARK: - Navigation
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let dvc = segue.destinationViewController as? PublicationViewController {
			dvc.publication = (navigationController?.viewControllers.first as? CourseDashboardViewController)?.course?.publications[(tableView.indexPathForSelectedRow?.item)!]
		}
	}
	
	// MARK: - NSCoding
	
	func saveUsers() {
		let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(knownUsers, toFile: User.ArchiveURL.path!)
		if !isSuccessfulSave {
			print("Failed to save users...")
		}
	}
	
	func saveCourses() {
		let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(knownCourses, toFile: Course.ArchiveURL.path!)
		if !isSuccessfulSave {
			print("Failed to save courses...")
		}
	}
}
