//
//  Course.swift
//  Swifty
//
//  Created by Sergey on 05.05.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

struct Course {

	// MARK: - Properties
	
	var sigature: String
	
	let name: String
	let university: String
	var rating = 0
	var courseImage: UIImage?
	
	var students = [User]()
	var instructor: User?
	
	var overview: String?
	var outline = [String]()
	
	var publications = [String]()
	
	static var knownCourses = [Course]()
	
	// MARK: - Initaialization
	
	init(name: String, university: String, promo: String) {
		self.name = name
		self.university = university
		self.sigature = promo
	}
	
	init(name: String, university: String, rating: Int, image: UIImage?, promo: String, instructor: User?) {
		self.name = name
		self.university = university
		self.rating = rating
		self.courseImage = image ?? UIImage(named: "defaultPhoto")!
		self.sigature = promo
	}

	// MARK: - Actions
	// TODO: - Perform reading from CoreData
	static func loadCourses() {
		knownCourses = [
			Course(name: "Developing iOS apps", university: "Stanford", rating: 5, image: nil, promo: "CS193p", instructor: User.getUserWithLogin("paulhegarty@icloud.com")!),
			Course(name: "Machine Learning", university: "MIT", rating: 3, image: nil, promo: "MIT-ML", instructor: nil),
			Course(name: "Intro to Alghorithms", university: "Harvard", rating: 4, image: nil, promo: "ALG", instructor: nil)
		]
	}
	
	static func getCourseBySignature(promo: String) -> Course? {
		for knownCourse in knownCourses {
			if promo == knownCourse.sigature {
				return knownCourse
			}
		}
		return nil
	}
}