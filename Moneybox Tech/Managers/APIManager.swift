//
//  APIManager.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 30/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import UIKit

///A list of constants needed to interact with the API
fileprivate struct Constants {
	static let apiURL = "https://api-test00.moneyboxapp.com"
	static let appID = "8cb2237d0679ca88db6464"
	static let appVersion = "4.0.0"
	static let apiVersion = "3.0.0"
}

///Enum containing the API end points
fileprivate enum EndPoints: String {
	case login = "/users/login"
	case products = "/investorproduct/thisweek"
	case payment = "/oneoffpayments"
	case logout = "/users/logout"
}

public enum APIManagerError:Error {
	case failedToCreateRequest
	case failedToEncodeLoginData
	case failedToEncodePaymentData
}

///Interacts with the Moneybox API
class APIManager: NSObject {
	let dataManager: DataManager
	
	init(dataManager dM: DataManager) {
		self.dataManager = dM
	}
	
	//MARK: - Private
	
	/**
	Creates the request to specified end point, with all necessary headers
	- Parameter endPoint: An `Endpoint` object specifying the API end point
	- Returns: A complete `URLRequest` ready to use
	*/
	private func createRequest(to endPoint: EndPoints) -> URLRequest? {
		let fullURLString = Constants.apiURL + endPoint.rawValue
		guard let url = URL(string: fullURLString) else {
			return nil
		}
		
		var request = URLRequest(url: url)
		request.addValue(Constants.appID, forHTTPHeaderField: "AppId")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue(Constants.appVersion, forHTTPHeaderField: "appVersion")
		request.addValue(Constants.apiVersion, forHTTPHeaderField: "apiVersion")
		
		let sessionData = self.dataManager.getSession()
		if let session = sessionData.session {
			let bearerString = "Bearer " + session.bearerToken
			request.addValue(bearerString, forHTTPHeaderField: "Authorization")
		}
		
		switch endPoint {
		case .products:
			request.httpMethod = "GET"
			break
		default:
			request.httpMethod = "POST"
		}
		
		return request
	}
	
	/**
	Uses a standard URLSession to complete the request.
	- Parameters:
		- request: The `URLRequest` to complete
		- completion: The block to run when the `JSON` is returned
		- response: The data returned from the `JSON`
		- error: Any errors that may have occured
	*/
	private func completeTask(request: URLRequest,
							  completion: ((_ response: Data?, _ error: Error?) -> Void)?) {
		let config = URLSessionConfiguration.default
		let session = URLSession(configuration: config)
		let task = session.dataTask(with: request) { (responseData, response, responseError) in
			guard responseError == nil else {
				completion?(nil, responseError)
				return
			}
			
			completion?(responseData, nil)
		}
		task.resume()
	}
	
	//MARK: - Public
	
	/**
	Uses the `LoginData` to send a log in request to the API
	- Parameters:
		- userData: A `LoginData` object containing the user credentials
		- completion: The block to run when the `JSON` is returned
		- response: The data returned from the `JSON`
		- error: Any errors that may have occured
	*/
	public func logIn(userData: LoginData,
					  completion: @escaping (_ response: Data?, _ error: Error?) -> Void) {
		guard var request = createRequest(to: .login) else {
			completion(nil, APIManagerError.failedToCreateRequest)
			return
		}
		
		guard let encodedLogin = try? JSONEncoder().encode(userData) else {
			completion(nil, APIManagerError.failedToEncodeLoginData)
			return
		}
		
		request.httpBody = encodedLogin
		
		completeTask(request: request,
					 completion: completion)
	}
	
	/**
	Sends a request to fetch the account data
	- Parameters:
		- completion: The block to run when the `JSON` is returned
		- response: The data returned from the `JSON`
		- error: Any errors that may have occured
	*/
	public func fetchAccounts(completion: @escaping (_ response: Data?, _ error: Error?) -> Void) {
		guard let request = createRequest(to: .products) else {
			completion(nil, APIManagerError.failedToCreateRequest)
			return
		}
		
		completeTask(request: request,
					 completion: completion)
	}
	
	
	/**
	Sends a request to add a fixed amount to the selected account
	- Parameters:
		- account: The `Account` object to add the funds to
		- completion: The block to run when the `JSON` is returned
		- response: The data returned from the `JSON`
		- error: Any errors that may have occured
	*/
	public func addPayment(to account: Account,
						   completion: @escaping (_ response: Data?, _ error: Error?) -> Void) {
		guard var request = createRequest(to: .payment) else {
			completion(nil, APIManagerError.failedToCreateRequest)
			return
		}
		
		let payment = PaymentData(amount: 10,
								  investorProductId: account.investorProductID)
		
		guard let encodedPayment = try? JSONEncoder().encode(payment) else {
			completion(nil, APIManagerError.failedToEncodePaymentData)
			return
		}
		
		request.httpBody = encodedPayment
		
		completeTask(request: request,
					 completion: completion)
	}
	
	/**
	Sends a log out request to the API
	- Returns: An `APIManagerError` if needed or nil
	*/
	public func logoutUser() -> APIManagerError? {
		guard let request = createRequest(to: .logout) else {
			return .failedToCreateRequest
		}
		
		completeTask(request: request,
					 completion: nil)
		return nil
	}
}
