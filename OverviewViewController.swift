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
	@IBOutlet weak var courseDescription: UITextView!
	
	weak var course: Course?
	
	//MARK: - Loading
	
	override func viewDidLoad() {
		let dashboardController = navigationController?.viewControllers.first as? CourseDashboardViewController

		courseName.text = dashboardController?.course?.name
		universityName.text = dashboardController?.course?.university
		courseImage.image = dashboardController?.course?.courseImage ?? UIImage(named: "defaultImage")!
		duration.text = dashboardController?.course?.duration
		instructor.text = "\((dashboardController?.course?.instructor?.firstName)!) \((dashboardController?.course?.instructor?.secondName)!)"
		creationDate.text = dashboardController?.course?.created?.description
		updatedDate.text = dashboardController?.course?.updated?.description
		courseDescription.text = dashboardController?.course?.courseDescription
	}
}
