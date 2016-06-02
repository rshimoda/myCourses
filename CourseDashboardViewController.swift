//
//  CourseDashboardViewController.swift
//  NextSTEP
//
//  Created by Sergey on 5/24/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class CourseDashboardViewController: UITabBarController {

	// MARK: - Properties
	
	var course: Course?
	var courseID: Int?
	
	var user: User?
	
	// MARK: - Loading
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard user?.login == course?.instructor?.login else {
			tabBar.items?.last?.enabled = false
			return
		}
	}
	
	//MARK: - Actions
	
	@IBAction func share(sender: UIBarButtonItem) {
		let vc = UIActivityViewController(activityItems: ["I've just got envolved to \((course?.name)!) by \((course?.university)!) #NextSTEP", (course?.courseImage)!], applicationActivities: nil)

		self.presentViewController(vc, animated: true, completion: nil)

	}
	
	@IBAction func saveRatingAndUnwindToCourseDashboard(sender: UIStoryboardSegue) {
		if let svc = sender.sourceViewController as? RateCourseViewController {
			knownCourses[knownCourses.indexOf(Course.getCourseBySignature((course?.sigature)!)!)!].rates += [svc.ratingControl.rating]
			
			course = Course.getCourseBySignature((course?.sigature)!)
			
			saveCourses()
		}
	}
	
	// MARK: - NSCoding
	
	func saveCourses() {
		let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(knownCourses, toFile: Course.ArchiveURL.path!)
		if !isSuccessfulSave {
			print("Failed to save courses...")
		}
	}
}
