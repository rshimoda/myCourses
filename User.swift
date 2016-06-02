//
//  User.swift
//  Swifty
//
//  Created by Sergey on 05.05.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import Foundation

var knownUsers = [User]()

class User: NSObject, NSCoding {

	// MARK: - Properties
	
	let firstName: String
	let secondName: String
	var login: String
	var password: String
	var image: UIImage?
	var courses = [Course]()
	var coursesPromos = [String]()
	
	// MARK: - Actions
	
	static func getUserWithLogin(login: String, password: String) -> User? {
		for knownUser in knownUsers {
			if knownUser.login == login && knownUser.password == password {
				return knownUser
			}
		}
		return nil
	}
	
	static func getUserWithLogin(login: String) -> (User?, Int?) {
		for knownUser in knownUsers {
			if knownUser.login == login {
				return (knownUser, knownUsers.indexOf(knownUser))
			}
		}
		return (nil, nil)
	}
	
	static func addUser(user: User) -> Bool {
		for knownUser in knownUsers {
			if knownUser.login == user.login {
				return false
			}
		}
		knownUsers.append(user)
		
		return true
	}
	
	static func updateCourseToAllUsers(course: Course) {
		for i in 0..<knownUsers.count {
			for j in 0..<knownUsers[i].courses.count {
				if knownUsers[i].courses[j].sigature == course.sigature {
					knownUsers[i].courses[j] = course
				}
			}
		}
	}
	
	// MARK: - Types
	
	struct PropertyKey {
		static let firstNameKey = "firstName"
		static let lastNameKey = "lastName"
		static let loginKey = "login"
		static let passwordKey = "password"
		static let imageKey = "image"
		static let coursesKey = "courses"
		static let completedAssignmentsKey = "completedAssignments"
	}
	
	// MARK: - NSCoding
	
	func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(firstName, forKey: PropertyKey.firstNameKey)
		aCoder.encodeObject(secondName, forKey: PropertyKey.lastNameKey)
		aCoder.encodeObject(login, forKey: PropertyKey.loginKey)
		aCoder.encodeObject(password, forKey: PropertyKey.passwordKey)
		aCoder.encodeObject(image, forKey: PropertyKey.imageKey)
		aCoder.encodeObject(courses, forKey: PropertyKey.coursesKey)
	}
	
	required convenience init?(coder aCoder: NSCoder) {
		let firstName = aCoder.decodeObjectForKey(PropertyKey.firstNameKey) as! String
		let lastName = aCoder.decodeObjectForKey(PropertyKey.lastNameKey) as! String
		let login = aCoder.decodeObjectForKey(PropertyKey.loginKey) as! String
		let password = aCoder.decodeObjectForKey(PropertyKey.passwordKey) as! String
		let image = aCoder.decodeObjectForKey(PropertyKey.imageKey) as? UIImage
		let courses = aCoder.decodeObjectForKey(PropertyKey.coursesKey) as! [Course]
		
		
		self.init(login: login, password: password, firstName: firstName, secondName: lastName, image: image, courses: courses)
	}
		
	// MARK: - Initialization
	
	init(login: String, password: String, firstName: String, secondName: String) {
		self.login = login
		self.password = password
		self.firstName = firstName
		self.secondName = secondName
		
		super.init()
	}
	
	private init(login: String, password: String, firstName: String, secondName: String, image: UIImage?, courses: [Course]) {
		self.login = login
		self.password = password
		self.firstName = firstName
		self.secondName = secondName
		self.image = image
		self.courses = courses
		
		super.init()
	}
	
	// MARK: - Arciving Paths
	
	static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
	static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("users")
}