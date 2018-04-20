//
//  AccountsViewController.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 29/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var accountsTableView: UITableView!
	
	weak var apiManager: APIManager?
	weak var dataManager: DataManager?
	weak var alertManager: AlertManager?
	
	var user: User = User()
	var selectedAccount: Account?
	
	override func viewDidLoad() {
        super.viewDidLoad()

        checkForAccounts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	//MARK: - Data
	
	func checkForAccounts() {
		guard let possUser = self.dataManager?.getUser() else {
			//FIXME: do something to get user
			return
		}
		user = possUser
		
		let accounts = user.getAccounts()
		
		if accounts.count == 0 {
			fetchAccounts()
		} else {
			accountsTableView.reloadData()
		}
	}
	
	func fetchAccounts() {
		self.apiManager?.fetchAccounts(completion: { (data, error) in
			guard error == nil else {
				DispatchQueue.main.async {
					self.resolve(error: error!)
				}
				return
			}
			
			guard let data = data else {
				return
			}
			
			guard let response = try? JSONDecoder().decode(AccountsResponse.self, from: data) else {
				DispatchQueue.main.async {
					self.attemptToDecodeJSON(data: data)
				}
				return
			}
			
			self.user.setAccounts(accounts: response.accounts)
			
			DispatchQueue.main.async {
				self.accountsTableView.reloadData()
			}
		})
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
	
	//MARK: - Table View
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return user.getAccounts().count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return ""
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return tableView.dequeueReusableCell(withIdentifier: "AccountCell",
											 for: indexPath)
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let account = user.getAccounts()[indexPath.section]
		
		cell.textLabel?.text = account.product.friendlyName
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.selectedAccount = user.getAccounts()[indexPath.section]
		self.performSegue(withIdentifier: "AccountDetail",
						  sender: self)
	}
	
	// MARK: - Navigation
	
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		if identifier == "AccountDetail" {
			if selectedAccount == nil {
				return false
			}
		}
		
		return true
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "AccountDetail" {
			let productVC = segue.destination as! ProductViewController
			
			productVC.account = self.selectedAccount!
			productVC.apiManager = self.apiManager
			productVC.alertManager = self.alertManager
		}
	}
}
