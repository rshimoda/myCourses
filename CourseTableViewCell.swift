//
//  CourseTableViewCell.swift
//  Swifty
//
//  Created by Sergey on 06.05.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

	// MARK: - Properties
	
	@IBOutlet weak var courseName: UILabel!
	@IBOutlet weak var universityName: UILabel!
	@IBOutlet weak var photoImageView: UIImageView!
	@IBOutlet weak var ratingControl: RatingControl!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
