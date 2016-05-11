//
//  Course.swift
//  Swifty
//
//  Created by Sergey on 05.05.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class Course {

	// MARK: - Properties
	
	let name: String
	let university: String
	var numberOfStudentsInvolved = 0
	var rating = 0
	var courseImage: UIImage?
	
	// MARK: - Initaialization
	
	init(name: String, university: String) {
		self.name = name
		self.university = university
	}
}