//
//  Publication.swift
//  NextSTEP
//
//  Created by Sergey on 6/2/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import Foundation

class Publication: NSObject, NSCoding {
	
	// MARK: - Properties
	
	var name: String
	var material: String
	var image: UIImage?
	
	// MARK: - Initialization
	
	init(name: String, material: String) {
		self.name = name
		self.material = material
	}
	
	private init(name: String, material: String, image: UIImage?) {
		self.name = name
		self.material = material
		self.image = image
	}
	
	// MARK: - NSCoding
	
	required convenience init?(coder aCoder: NSCoder) {
		let name = aCoder.decodeObjectForKey("publicationName") as! String
		let materials = aCoder.decodeObjectForKey("publicationMaterial") as! String
		let image = aCoder.decodeObjectForKey("publicationImage") as! UIImage?
		
		self.init(name: name, material: materials, image: image)
	}
	
	func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(name, forKey: "publicationName")
		aCoder.encodeObject(material, forKey: "publicationMaterial")
		aCoder.encodeObject(image, forKey: "publicationImage")
	}
}

class Assignment: NSObject {
	
	// MARK: - Properties

	var name: String
	var task: String
	var dueDate: NSDate
	var questions = [Question]()
	
	// MARK: - Initialization
	
	init(name: String, task: String, dueDate: NSDate) {
		self.name = name
		self.task = task
		self.dueDate = dueDate
		
		super.init()
	}
}

class Question: NSObject {
	
	// MARK: - Properties

	var name: String
	var correctAnswer: String
	var mark: Int
	
	// MARK: - Initialization

	init(name: String, answer: String, mark: Int) {
		self.name = name
		self.correctAnswer = answer
		self.mark = mark
		
		super.init()
	}
}
