//
//  Course.swift
//  Swifty
//
//  Created by Sergey on 05.05.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

var knownCourses = [Course]()

class Course: NSObject, NSCoding {

	// MARK: - Properties
	
	let defaults = NSUserDefaults.standardUserDefaults()
	
	var sigature: String
	
	let name: String
	let university: String

	var rates = [Int]()
	var rating: Int {
		return rates.reduce(0, combine: { $0+$1 }) / rates.count
	}
	
	var courseImage: UIImage?
	
	var students = [User]()
	var instructor: User?
	
	var duration: String?
	var created: NSDate?
	var updated: NSDate?
	var courseDescription: String?
	
	var outline = [String]()
	var publications = [Publication]()
	
	// MARK: - Actions
	
	static func getCourseBySignature(promo: String) -> Course? {
		for knownCourse in knownCourses {
			if promo == knownCourse.sigature {
				return knownCourse
			}
		}
		return nil
	}
	
	// MARK: - Types
	
	private struct PropertyKey {
		static let signatureKey = "coursePromo"
		static let nameKey = "courseName"
		static let universityKey = "courseUniversity"
		static let ratesKey = "courseRates"
		static let imageKey = "courseImage"
		static let instructorKey = "courseInstructor"
		static let durationKey = "courseDuration"
		static let creationKey = "courseCreation"
		static let updatedKey = "courseUpdate"
		static let descriptionKey = "courseDescription"
		static let outlineKey = "outline"
		static let publicationsKey = "publications"
	}
	
	// MARK: - NSCoding
	
	func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(sigature, forKey: PropertyKey.signatureKey)
		aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
		aCoder.encodeObject(university, forKey: PropertyKey.universityKey)
		aCoder.encodeObject(rates, forKey: PropertyKey.ratesKey)
		aCoder.encodeObject(courseImage, forKey: PropertyKey.imageKey)
		aCoder.encodeObject(instructor, forKey: PropertyKey.instructorKey)
		aCoder.encodeObject(duration, forKey: PropertyKey.durationKey)
		aCoder.encodeObject(created, forKey: PropertyKey.creationKey)
		aCoder.encodeObject(updated, forKey: PropertyKey.updatedKey)
		aCoder.encodeObject(courseDescription, forKey: PropertyKey.descriptionKey)
		aCoder.encodeObject(outline, forKey: PropertyKey.outlineKey)
		aCoder.encodeObject(publications, forKey: PropertyKey.publicationsKey)
	}
	
	required convenience init?(coder aCoder: NSCoder) {
		let promo = aCoder.decodeObjectForKey(PropertyKey.signatureKey) as! String
		let name = aCoder.decodeObjectForKey(PropertyKey.nameKey) as! String
		let university = aCoder.decodeObjectForKey(PropertyKey.universityKey) as! String
		let rates = aCoder.decodeObjectForKey(PropertyKey.ratesKey) as! [Int]
		let image = aCoder.decodeObjectForKey(PropertyKey.imageKey) as! UIImage?
		let instructor = aCoder.decodeObjectForKey(PropertyKey.instructorKey) as! User?
		let duration = aCoder.decodeObjectForKey(PropertyKey.durationKey) as! String
		let creation = aCoder.decodeObjectForKey(PropertyKey.creationKey) as! NSDate
		let update = aCoder.decodeObjectForKey(PropertyKey.updatedKey) as! NSDate
		let descr = aCoder.decodeObjectForKey(PropertyKey.descriptionKey) as! String
		let outline = aCoder.decodeObjectForKey(PropertyKey.outlineKey) as! [String]
		let publications = aCoder.decodeObjectForKey(PropertyKey.publicationsKey) as! [Publication]
		
		self.init(promo: promo, name: name, university: university, rates: rates, image: image, instructor: instructor, duration: duration, creation: creation, update: update, courseDescription: descr, outline: outline, publications: publications)
	}
	
	// MARK: - Initaialization
	
	init(name: String, university: String, promo: String) {
		self.name = name
		self.university = university
		self.sigature = promo
	}
	
	private init(promo: String, name: String, university: String, rates: [Int], image: UIImage?, instructor: User?, duration: String, creation: NSDate, update: NSDate, courseDescription: String, outline: [String], publications: [Publication]) {
		self.sigature = promo
		self.name = name
		self.university = university
		self.rates = rates
		self.courseImage = image
		self.instructor = instructor
		self.duration = duration
		self.created = creation
		self.updated = update
		self.courseDescription = courseDescription
		self.outline = outline
		self.publications = publications
	}
	
	// MARK: - Arciving Paths
	
	static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
	static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("courses")


	// MARK: - Actions
	// TODO: - Perform reading from CoreData
//	static func loadCourses() {
//		let course1 = Course(name: "Developing iOS apps", university: "Stanford", promo: "CS193p")
//		course1.rating = 5
//		course1.courseImage = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://a5.mzstatic.com/us/r30/CobaltPublic5/v4/82/13/4b/82134b13-3e4f-18be-0010-3fedbf796295/d3_100_2x.png")!)!) ?? UIImage(named: "defaultImage")!
//		course1.instructor = User.getUserWithLogin("paulhegarty@icloud.com")
//		course1.duration = "9 weeks"
//		course1.created = NSDate()
//		course1.updated = NSDate()
//		course1.courseDescription = "Updated for iOS 9 and Swift. Tools ans APIs required to build applications for the iPhone and iPad platforms using the iOS SDK."
//		course1.outline = ["1. Introduction to iOS, Xcode 7, and Swift", "2. Using MVC in iOS", "3. Swift and Foundation Framework"]
//		
//		let course2 = Course(name: "Intro to Micro-controllers", university: "Michigan's MI Learning", promo: "MI28c")
//		course2.rating = 3
//		course2.courseImage = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://ecx.images-amazon.com/images/I/51o3974xwIL._OU03_AC_UL320_SR200,320_.jpg")!)!) ?? UIImage(named: "defaultImage")!
//		course2.instructor = User.getUserWithLogin("paulhegarty@icloud.com")
//		course2.duration = "12 weeks"
//		course2.created = NSDate()
//		course2.updated = NSDate()
//		course2.courseDescription = "Pre-Ingineiring: Electronics woth Micro-Controllers introduces students to simple circuitry and programming as they learn simple programming as they learn to use th Arduino platform."
//		course2
//		course2.outline = ["1. Unit 1 - Welcome to Electronics", "2. Unit 2 - Resistence is Futile"]
//		
//		let course3 = Course(name: "Machine Learning", university: "Stanford", promo: "CS290")
//		course3.rating = 4
//		course3.courseImage = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://3.bp.blogspot.com/-u7Fkk8haI40/TuOkKrTbbWI/AAAAAAAADUU/Hsib8G7daYA/s1600/ml-robot.png")!)!) ?? UIImage(named: "defaultImage")!
//		course3.instructor = User.getUserWithLogin("paulhegarty@icloud.com")
//		course3.duration = "10 weeks"
//		course3.created = NSDate()
//		course3.updated = NSDate()
//		course3.courseDescription = "This course is provides a broad introduction to machine learning and statistical pattern recognition."
//		course3.outline = ["1. Machine Learning Lecture 1"]
//		
//		knownCourses = [course1, course2, course3]
//	}
}