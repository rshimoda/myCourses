//
//  User.swift
//  Swifty
//
//  Created by Sergey on 05.05.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import Foundation

class User {

	// MARK: - Properties
	
	var firstName = ""
	var secondName = ""
	let id = Int(arc4random())
	
	var courses = [Course]()
	
	static var currentUser: User?
	
	private static let knownUsers = [
		"r.shimoda@icloud.com": "dasmo",
		"phegarty@icloud.com": "AAPL"
	]
	
	// TODO: Load from CoreData/NSUserDefaults
	
	private static var users = [String: User]()
		
	// MARK: - Initialization
	
	init(firstName: String, secondName: String) {
		self.firstName = firstName
		self.secondName = secondName
	}
	
	// MARK: - Actions
	
	static func loadUserData() {
		// Load users from CoreData/NSUserDefaults...
	}
	
	static func getUserIfExists(login: String, password: String) -> User? {
		guard knownUsers[login] == password else {
			return nil
		}
		
		return users[login]!
	}
}