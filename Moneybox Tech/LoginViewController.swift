//
//  LoginViewController.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 29/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import UIKit

//TODO: respond to keyboard layout

class LoginViewController: UIViewController {
	@IBOutlet weak var loginStackView: UIStackView!
	@IBOutlet weak var errorMessageLabel: ErrorMessageLabel!
	@IBOutlet weak var emailTextField: EmailTextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
	
	@IBOutlet weak var userStackView: UIStackView!
	@IBOutlet weak var fullNameLabel: UILabel!
	@IBOutlet weak var accountsButton: UIButton!
	@IBOutlet weak var logoutButton: UIButton!
	
	var dataManager: DataManager?
	var apiManager: APIManager?
	var alertManager: AlertManager?

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let tap = UITapGestureRecognizer(target: self,
										 action: #selector(didTapView))
		self.view.addGestureRecognizer(tap)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.updateUI()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	//MARK: - Gestures
	
	@objc func didTapView() {
		self.view.endEditing(true)
	}
	
	//MARK: - UI
	
	func shouldHideLoginStack(shouldHide: Bool) {
		self.userStackView.isHidden = !shouldHide
		self.loginStackView.isHidden = shouldHide
	}
	
	func updateUI() {
		let user = self.dataManager?.getUser()
		
		if user == nil {
			shouldHideLoginStack(shouldHide: false)
			//Prefill user info
			emailTextField.text = UserData.email
			passwordTextField.text = UserData.password
		} else {
			shouldHideLoginStack(shouldHide: true)
			
			let fullName = user!.firstName + " " + user!.lastName
			fullNameLabel.text = fullName
		}
	}
	
	//MARK: - Buttons
	
	@IBAction func didTapLogOutButton(sender: UIButton) {
		logoutButton.isEnabled = false
		defer {
			logoutButton.isEnabled = true
		}
		
		if let error = self.apiManager?.logoutUser() {
			print(error)
			return
		}
		
		self.dataManager?.logoutUser()
		shouldHideLoginStack(shouldHide: false)
	}
	
	@IBAction func didTapLoginButton(sender: UIButton) {
		loginButton.isEnabled = false
		
		if !emailTextField.validateEmail() {
			self.errorMessageLabel.displayError(message: "Email is incorrect.")
			loginButton.isEnabled = true
			return
		}
		
		let email = emailTextField.text!
		
		guard let password = passwordTextField.text else {
			self.errorMessageLabel.displayError(message: "Password too short.")
			loginButton.isEnabled = true
			return
		}
		
		let userData = LoginData(email: email,
								 password: password)
		
		self.apiManager?.logIn(userData: userData) { (data, error) in
			guard error == nil else {
				DispatchQueue.main.async {
					self.resolve(error: error!)
				}
				return
			}
			
			guard let data = data else {
				return
			}
			
			guard let response = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
				DispatchQueue.main.async {
					self.attemptToDecodeJSON(data: data)
				}
				return
			}
			
			let user = response.user
			let session = response.session
				
			self.dataManager?.setUser(user: user)
			self.dataManager?.setSession(session: session)
				
			DispatchQueue.main.async {
				self.updateUI()
				self.loginButton.isEnabled = true
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
			self.loginButton.isEnabled = true
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
		} else {
			self.errorMessageLabel.displayError(message: error.message)
			self.loginButton.isEnabled = true
		}
	}
	
	//MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "UserDetail" {
			let accountsVC = segue.destination as! AccountsViewController
			
			accountsVC.dataManager = self.dataManager
			accountsVC.apiManager = self.apiManager
			accountsVC.alertManager = self.alertManager
		}
	}
	
}
