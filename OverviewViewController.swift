//
//  OverviewViewController.swift
//  NextSTEP
//
//  Created by Sergey on 5/26/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
	
	//MARK: - Properties
	
	@IBOutlet weak var courseName: UILabel!
	@IBOutlet weak var universityName: UILabel!
	@IBOutlet weak var courseImage: UIImageView!

	@IBOutlet weak var duration: UILabel!
	@IBOutlet weak var instructor: UILabel!
	@IBOutlet weak var creationDate: UILabel!
	@IBOutlet weak var updatedDate: UILabel!
	
	var course: Course!
	
	//MARK: - Loading
	
	override func viewDidLoad() {
		courseName.text = course.name
		universityName.text = course.university
		courseImage.image = course.courseImage
		
		instructor.text = "\(course.instructor?.firstName) \(course.instructor?.secondName)"
		
		// TODO: Add dates values
	}
}
