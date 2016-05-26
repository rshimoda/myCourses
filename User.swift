//
//  User.swift
//  Swifty
//
//  Created by Sergey on 05.05.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import Foundation

class User {
	
	private enum Status {
		case Student
		case Teacher
	}

	// MARK: - Properties
	
	let firstName: String
	let secondName: String
	let login: String
	private let password: String
	private let status: Status
	let id = arc4random()
	var image: UIImage?
	var courses = [Course]()
	
	private static var knownUsers = [User]()
	
	// MARK: - Methods
	
	static func getUserWithLogin(login: String, password: String) -> User? {
		for knownUser in knownUsers {
			if knownUser.login == login && knownUser.password == password {
				return knownUser
			}
		}
		return nil
	}
	
	static func getUserWithLogin(login: String) -> User? {
		for knownUser in knownUsers {
			if knownUser.login == login {
				return knownUser
			}
		}
		return nil
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
		
	// MARK: - Initialization
	
	init(login: String, password: String, isTeacher: Bool, firstName: String, secondName: String) {
		self.login = login
		self.password = password
		self.status = isTeacher ? Status.Teacher : Status.Student
		self.firstName = firstName
		self.secondName = secondName
	}
	
	// TODO: - Perform reading from CoreData
	
	static func loadUsers() {
		knownUsers = [
			User(
				login: "admin",
				password: "123",
				isTeacher: true,
				firstName: "Admin",
				secondName: ""
			),
			User(
				login: "paulhegarty@icloud.com",
				password: "312",
				isTeacher: true,
				firstName: "Paul",
				secondName: "Hegarty"
			),
			User(
				login: "r.shimoda@icloud.com",
				password: "123",
				isTeacher: false,
				firstName: "Sergey",
				secondName: "Popov"
			)
		]
	}
	
	func loadCourses() {
		if self.firstName == "Sergey" {
			self.courses = [Course.knownCourses.first!]
		} else if self.firstName == "Admin" {
			self.courses = Course.knownCourses
		}
	}
}