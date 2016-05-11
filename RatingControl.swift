//
//  RatingControl.swift
//  Swifty
//
//  Created by Sergey on 06.05.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
	
	// MARK: - Properties
	
	var rating = 0 {
		didSet {
			setNeedsLayout()
		}
	}
	var ratingButtons = [UIButton]()
	let spacing = 5
	let startCount = 5
	
	// MARK: - Initialization
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		let emptyStarImage = UIImage(named: "emptyStar")
		let filledStarImage = UIImage(named: "filledStar")
		
		for _ in 0..<startCount {
			let button = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
			button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
			button.setImage(emptyStarImage, forState: .Normal)
			button.setImage(filledStarImage, forState: .Selected)
			button.setImage(filledStarImage, forState: [.Highlighted, .Focused])
			button.adjustsImageWhenHighlighted = false
			ratingButtons += [button]
			addSubview(button)
		}
	}
	
	override func intrinsicContentSize() -> CGSize {
		return CGSize(width: 240, height: 22)
	}
	
	override func layoutSubviews() {
		var buttonFrame = CGRect(x: 0, y: 0, width: 22, height: 22)
		
		 // Offset each button's origin by the length of the button plus spacing.
		for (index, button) in ratingButtons.enumerate() {
			buttonFrame.origin.x = CGFloat(index * (22 + spacing))
			button.frame = buttonFrame
		}
		
		updateButtonSelectionState()
	}

	// MARK: - Button Action
	
	func ratingButtonTapped(button: UIButton) {
		rating = ratingButtons.indexOf(button)! + 1
		updateButtonSelectionState()
	}
	
	func updateButtonSelectionState() {
		for (index, button) in ratingButtons.enumerate() {
			button.selected = index < rating
		}
	}
	
}
