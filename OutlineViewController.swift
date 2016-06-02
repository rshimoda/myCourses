//
//  OutlineViewController.swift
//  NextSTEP
//
//  Created by Sergey on 5/26/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class OutlineViewController: UIViewController {

	@IBOutlet weak var scrollView: UIScrollView!
	
	override func viewDidLoad() {
		weak var dashboardController = navigationController?.viewControllers.first as? CourseDashboardViewController
		var shiftForY: CGFloat = 0

		for outline in (dashboardController?.course?.outline)! {
			let label = UILabel(frame: CGRect(x: 0, y: shiftForY, width: view.frame.width, height: CGFloat(30)))
			label.text = outline
			scrollView.addSubview(label)
			
			shiftForY += 30
		}
	}
}
