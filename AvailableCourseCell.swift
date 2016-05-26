//
//  AvailableCourseCell.swift
//  NextSTEP
//
//  Created by Sergey on 5/25/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class AvailableCourseCell: UITableViewCell {

	@IBOutlet weak var courseName: UILabel!
	@IBOutlet weak var promo: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
}
