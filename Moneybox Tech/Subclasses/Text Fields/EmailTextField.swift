//
//  EmailTextField.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 31/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import UIKit

class EmailTextField: NextResponderTextField {
	func validateEmail() -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		
		let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: self.text)
	}
}
