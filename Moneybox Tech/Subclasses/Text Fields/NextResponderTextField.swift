//
//  NextResponderTextField.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 30/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import UIKit

class NextResponderTextField: UITextField {
	@IBOutlet weak var theNextResponder: UIResponder!

	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.layer.cornerRadius = 5
		self.layer.borderColor = UIColor.black.cgColor
		self.layer.borderWidth = 1.0
		
		self.addTarget(self,
					   action: #selector(keyboardActionButtonTapped(sender:)),
					   for: .editingDidEndOnExit)
	}
	
	@objc private func keyboardActionButtonTapped(sender: UITextField) {
		if self.theNextResponder.isKind(of: UIButton.self) {
			let button = self.theNextResponder as! UIButton
			button.sendActions(for: .touchUpInside)
		} else {
			self.theNextResponder.becomeFirstResponder()
		}
		self.resignFirstResponder()
	}

}
