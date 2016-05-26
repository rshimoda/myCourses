//
//  CourseOverviewViewController.swift
//  NextSTEP
//
//  Created by Sergey on 5/24/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class InfoViewController: UITableViewController {

	// MARK: - Properties
	
	@IBOutlet weak var courseNameLabel: UILabel!
	@IBOutlet weak var universityNameLabel: UILabel!
	@IBOutlet weak var courseImage: UIImageView!
	
	// MARK: - Loading
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let dashboardController = tabBarController as? CourseDashboardViewController
		courseNameLabel.text = dashboardController?.course?.name
		universityNameLabel.text = dashboardController?.course?.university
		courseImage.image = dashboardController?.course?.courseImage
		
		self.tableView.tableFooterView = UIView(frame: CGRectZero)
	}
	
	// MARK: - Table view data source
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// Return the number of rows
		return 4
	}
	
	/*
	// Override to support conditional editing of the table view.
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
	// Return false if you do not want the specified item to be editable.
	return true
	}
	*/
	
	/*
	// Override to support editing the table view.
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
	if editingStyle == .Delete {
	// Delete the row from the data source
	tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
	} else if editingStyle == .Insert {
	// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
	}
	*/
	
	/*
	// Override to support rearranging the table view.
	override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
	
	}
	*/
	
	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
	// Return false if you do not want the item to be re-orderable.
	return true
	}
	*/
	//__________________________________________________________________________________________________________________
	

	// MARK: - Navigation
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "Show Overview" {
			if let dvc = segue.destinationViewController as? OverviewViewController {
				dvc.course = (tabBarController as? CourseDashboardViewController)?.course
			}
		}
	}
	
	
}
