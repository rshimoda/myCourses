//
//  InstructorViewController.swift
//  NextSTEP
//
//  Created by Sergey on 5/26/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class InstructorViewController: UIViewController {

	@IBOutlet weak var instructorImage: UIImageView!
	@IBOutlet weak var firstName: UILabel!
	@IBOutlet weak var lastName: UILabel!
	@IBOutlet weak var initials: UILabel!
	@IBOutlet weak var university: UILabel!
	@IBOutlet weak var info: UILabel!
	
	override func viewDidLoad() {
		let dashboardController = navigationController?.viewControllers.first as? CourseDashboardViewController

		if let image = dashboardController?.course?.instructor?.image {
			instructorImage.image = image
		}
		instructorImage.tintColor = UIColor.darkGrayColor()
		firstName.text = dashboardController?.course?.instructor?.firstName
		lastName.text = dashboardController?.course?.instructor?.secondName
		university.text = dashboardController?.course?.university
		
		let firstNameLetter = dashboardController?.course?.instructor?.firstName[(dashboardController?.course?.instructor?.firstName.startIndex)!] ?? " "
		let secondNameLetter = dashboardController?.course?.instructor?.secondName[(dashboardController?.course?.instructor?.secondName.startIndex)!] ?? " "
		initials.text = String([ firstNameLetter, secondNameLetter ])
	}
}
