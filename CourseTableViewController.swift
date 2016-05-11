//
//  CourseTableViewController.swift
//  Swifty
//
//  Created by Sergey on 06.05.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit


class CourseTableViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, SignInDelegate {
	
	// MARK: - Properties
	
	var user = User.currentUser {
		willSet {
			User.currentUser = newValue
		}
	}
	@IBOutlet weak var signUpBarButtonItem: UIBarButtonItem!

	// MARK: - Loading
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.emptyDataSetSource = self
		tableView.emptyDataSetDelegate = self
		
		tableView.tableFooterView = UIView()
		
		if user != nil {
			signUpBarButtonItem.tintColor = UIColor.grayColor()
		} else {
			signUpBarButtonItem.tintColor = UIColor.blueColor()
		}

		if user != nil {
			loadCourses()
		}
		
		self.tableView.reloadData()
		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
	
	func loadCourses() {
		let courseImage = UIImage(named: "defaultImage")
		let course1 = Course(name: "Developing iOS apps", university: "Stanford University")
		course1.rating = 5
		course1.courseImage = courseImage
		
		let course2 = Course(name: "Machine Learning", university: "MIT")
		course2.rating = 4
		course2.courseImage = courseImage
		
		user?.courses += [course1,  course2]
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: - DZEmptyDataSetDelegate & DZEmptyDataSetSource
	
	func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
		let str = "No courses yet..."
		let attrs = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)]
		return NSAttributedString(string: str, attributes: attrs)
	}
	
	func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
		let str = "Tap the button below to add your first course."
		let attrs = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleBody)]
		return NSAttributedString(string: str, attributes: attrs)
	}
	
	func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
		return UIImage(named: "defaultPhoto")
	}
	
	func buttonTitleForEmptyDataSet(scrollView: UIScrollView!, forState state: UIControlState) -> NSAttributedString! {
		let str = "Add Course"
		let attrs = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleCallout)]
		return NSAttributedString(string: str, attributes: attrs)
	}
	
	func emptyDataSetDidTapButton(scrollView: UIScrollView!) {
		let ac = UIAlertController(title: "You must sign in first!", message: nil, preferredStyle: .Alert)
		ac.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
		presentViewController(ac, animated: true, completion: nil)
	}
	
	// MARK: - SignInDelegate
	
	func setUser(name: String, password: String) -> Bool {
		if let newUser = User.getUserIfExists(name, password: password) {
			user = newUser
			return true
		} else {
			return false
		}
	}

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return user?.courses.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cellIdentifier = "CourseTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CourseTableViewCell
		

		let course = user?.courses[indexPath.row]
		
		cell.courseName.text = course!.name
		cell.universityName.text = course!.university
		cell.ratingControl.rating = course!.rating
		
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	@IBAction func unwindToCourseList(sender: UIStoryboardSegue) {
		if sender.sourceViewController is SignInViewController {
			
		}
	}

}
