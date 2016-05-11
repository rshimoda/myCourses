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
	
	let firstName: String
	let secondName: String
	let id = Int(arc4random())
	
	private static let knownUsers = [
		"r.shimoda@icloud.com": "dasmo",
		"phegarty@icloud.com": "AAPL"
	]
	
	private static var users = [String: User]()
		
	// MARK: - Initialization
	
	init(firstName: String, secondName: String) {
		self.firstName = firstName
		self.secondName = secondName
	}
	
	// MARK: - Actions
	
	static func loadUsers() {
		// Load users from CoreData/NSUserDefaults...
	}
	
	static func getUserIfExists(login: String, password: String) -> User? {
		guard knownUsers[login] == password else {
			return nil
		}
		
		return users[login]!
	}
}
