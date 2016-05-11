//
//  ViewController.swift
//  Swifty
//
//  Created by Sergey on 05.05.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SignInDataSource {
	
	// MARK: Properties
	var currentUser: User?
	@IBOutlet weak var addCourseTabBarItem: UIBarButtonItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
	}
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		if currentUser != nil {
			addCourseTabBarItem.enabled = true
		} else {
			addCourseTabBarItem.enabled = false
		}
	}
	
	// MARK: SignInDataSource
	func setUser(name: String, password: String) -> Bool {
		//currentUser = User(name, password)
		return true;
	}
	
	// MARK: Actions
	@IBAction func signUp(sender: UIBarButtonItem) {
		
	}
}

