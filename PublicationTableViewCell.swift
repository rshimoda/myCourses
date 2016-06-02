//
//  PublicationTableViewCell.swift
//  NextSTEP
//
//  Created by Sergey on 6/2/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class PublicationTableViewCell: UITableViewCell {
	
	// MARK: - Properties
	
	@IBOutlet weak var publication: UILabel!
	
	// MARK: - Initialization
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
}
