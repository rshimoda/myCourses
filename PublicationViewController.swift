//
//  PublicationViewController.swift
//  NextSTEP
//
//  Created by Sergey on 6/2/16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class PublicationViewController: UITableViewController {
	
	//MARK: - Properties
	
	@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var material: UITextView!
	
	var publication: Publication?
	
	// MARK: - Loading
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		name.text = publication?.name
		image.image = publication?.image
		material.text = publication?.material
	}
}
