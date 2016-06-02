//
//  CourseTableViewController.swift
//  Swifty
//
//  Created by Sergey on 06.05.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit


class CourseTableViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, SignInDelegate, AccountsDataSource {
	
	// MARK: - Properties
	
	let defaults = NSUserDefaults.standardUserDefaults()
	
	var user: User? {
		willSet {
			if newValue != nil {
				self.signUpBarButtonItem.tintColor = UIColor.lightGrayColor()
				self.addCourseBarButtunItem.enabled = true
//				self.navigationItem.leftBarButtonItems![1].enabled = true
			} else {
				self.signUpBarButtonItem.tintColor = UIColor.darkGrayColor()
				self.addCourseBarButtunItem.enabled = false
//				self.navigationItem.leftBarButtonItems![1].enabled = false
			}
		}
		didSet {
			defaults.setObject(user?.login, forKey: "currentUser")
			self.tableView.reloadData()
		}
	}
	
	private var id: Int?
	
	@IBOutlet weak var signUpBarButtonItem: UIBarButtonItem!
	@IBOutlet weak var addCourseBarButtunItem: UIBarButtonItem!
	//__________________________________________________________________________________________________________________

	// MARK: - Loading
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if let savedUsers = loadUsers() {
			knownUsers += savedUsers
		}
		
		if let savedCourses = loadCourses() {
			knownCourses += savedCourses
		}
		
		(user, id) = User.getUserWithLogin(defaults.stringForKey("currentUser") ?? "")
		
		tableView.emptyDataSetSource = self
		tableView.emptyDataSetDelegate = self
		tableView.tableFooterView = UIView()
		self.tableView.reloadData()
		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.leftBarButtonItems![1] = self.editButtonItem()
    }
	
	//__________________________________________________________________________________________________________________

	// MARK: - DZEmptyDataSetDelegate & DZEmptyDataSetSource
	
	func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
		return NSAttributedString(string: "Courses List Empty", attributes: [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)])
	}
	
	func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
		return NSAttributedString(string: "You can add course using '+' button.", attributes: [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleBody)])
	}
	
	func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
		return UIImage(named: "graduationBig")
	}
	//__________________________________________________________________________________________________________________

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
		cell.photoImageView.image = course!.courseImage
		
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
	
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
			user?.courses.removeAtIndex(indexPath.row)
			saveUsers()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		switch segue.identifier! {
		case "Sign Up":
			let nvc = segue.destinationViewController as! UINavigationController
			if let dvc = nvc.topViewController as? AccountTableViewController {
				dvc.delegate = self
			}
		case "Show Course":
			if let dvc = segue.destinationViewController as? UINavigationController {
				if let tbc = dvc.viewControllers.first as? CourseDashboardViewController {
					tbc.course = user?.courses[(tableView.indexPathForSelectedRow?.item)!]
					tbc.courseID = (tableView.indexPathForSelectedRow?.item)!
					tbc.user = user
				}
			}
		default: break
		}
	}
	
	@IBAction func unwindToCourseList(sender: UIStoryboardSegue) {
		if let svc = sender.sourceViewController as? AccountTableViewController {
			user = svc.user
		}
	}
	
	@IBAction func registerAndUnwindToCourseList(sender: UIStoryboardSegue) {
		let svc = sender.sourceViewController as! EmailTableViewController
		
		user = User.getUserWithLogin((svc.user?.login)!).0
		knownUsers.append(user!)
		saveUsers()
	}
	
	@IBAction func signInAndUnwindToCourseList(sender: UIStoryboardSegue) {
		let svc = sender.sourceViewController as! AccountTableViewController
		
		user = User.getUserWithLogin(svc.emailTextField.text ?? "", password: svc.passwordTextField.text ?? "")
	}
	
	@IBAction func signOutAndUnwindToCourseList(sender: UIStoryboardSegue) {
		user = nil
	}
	
	// MARK: - Actions
	
	@IBAction func addCourse(sender: UIBarButtonItem) {
		let alertController = UIAlertController(title: "Add new course", message: "Enter a course promo-code below", preferredStyle: .Alert)
		alertController.addTextFieldWithConfigurationHandler { (coursePromoTextField) in
			coursePromoTextField.placeholder = "Your Course's Promo Code"
		}
		alertController.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (addAction) in
			if let newCourse = Course.getCourseBySignature(alertController.textFields?.first?.text ?? "") {
				self.user?.courses += [newCourse]
//				knownUsers[self.id!].courses += [newCourse]
				self.tableView.reloadData()
				self.saveUsers()
			}
		}))
		alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
		presentViewController(alertController, animated: true, completion: nil)
	}
	
	// MARK: - NSCoding
	
	func saveUsers() {
		let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(knownUsers, toFile: User.ArchiveURL.path!)
		if !isSuccessfulSave {
			print("Failed to save users...")
		}
	}
	
	func loadUsers() -> [User]? {
		return NSKeyedUnarchiver.unarchiveObjectWithFile(User.ArchiveURL.path!) as? [User]
	}
	
	func loadCourses() -> [Course]? {
		return NSKeyedUnarchiver.unarchiveObjectWithFile(Course.ArchiveURL.path!) as? [Course]
	}
}
