//
//  ProductViewController.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 29/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
	@IBOutlet weak var moneyboxLabel: UILabel!
	@IBOutlet weak var addMoneyButton: UIButton!
	
	weak var apiManager: APIManager?
	weak var alertManager: AlertManager?
	weak var account: Account!

    override func viewDidLoad() {
        super.viewDidLoad()
		setAccountDetailLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	//MARK: - Data
	
	func setAccountDetailLabels() {
		self.title = account.product.friendlyName
		moneyboxLabel.text = "Your moneybox: £\(account.moneybox)"
	}
	
	//MARK: - Buttons
	
	@IBAction func didTapAddMoneyButton(sender: UIButton) {
		addMoneyButton.isEnabled = false
		self.apiManager?.addPayment(to: account) { (data, error) in
			guard error == nil else {
				DispatchQueue.main.async {
					self.resolve(error: error!)
				}
				return
			}
			
			guard let data = data else {
				return
			}
			
			if let resp = String(data: data, encoding: .utf8) {
				print(resp)
			}
			
			guard let payment = try? JSONDecoder().decode(PaymentResponse.self, from: data) else {
				DispatchQueue.main.async {
					self.attemptToDecodeJSON(data: data)
				}
				return
			}
			
			self.account.setMoneybox(moneybox: payment.moneybox)
			
			DispatchQueue.main.async {
				self.setAccountDetailLabels()
				self.addMoneyButton.isEnabled = true
			}
		}
	}
	
	//MARK: - Errors
	
	//TODO: move to own class
	func resolve(error: Error) {
		let errorCode = (error as NSError).code
		
		switch errorCode {
		case -1009:
			self.alertManager?.networkAlert(viewController: self)
			break
		default:
			return
		}
	}
	
	//TODO: move to own class
	func attemptToDecodeJSON(data: Data) {
		guard let error = try? JSONDecoder().decode(ErrorResponse.self, from: data) else {
			return
		}
		
		if error.name == "Bearer token expired" {
			self.alertManager?.bearerTokenExpired(viewController: self)
		}
	}
	
	//MARK: -
}
