//
//  ErrorMessageLabel.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 31/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import UIKit

class ErrorMessageLabel: UILabel {
	private(set) public var isDisplayingMessage: Bool = false
	
	func displayError(message: String) {
		if isDisplayingMessage {
			return
		}
		
		self.text = message
		self.isDisplayingMessage = true
		
		UIView.animate(withDuration: 0.3,
					   animations: {
						self.isHidden = false
		}) { (finished) in
			if finished {
				UIView.animate(withDuration: 0.3,
							   delay: 2.0,
							   options: .curveLinear,
							   animations: {
								self.isHidden = true
				},
							   completion: {(finished) in
								self.isDisplayingMessage = false
				})
			}
		}
	}
}
