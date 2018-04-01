//
//  User.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 29/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import Foundation

///An object that holds the data needed for the User
class User: Decodable {
	///User's first name
	private(set) public var firstName: String = ""
	
	///User's last name
	private(set) public var lastName: String = ""
	
	///User's UserID
	private(set) public var userId: String = ""
	
	///User's account data
	private var accounts: [Account] = []
	
	//Used to decode incoming JSON into the correct properties
	enum CodingKeys: String, CodingKey {
		case firstName = "FirstName"
		case lastName = "LastName"
		case userId = "UserId"
	}
	
	//MARK: - Accounts Get/Set
	
	/**
	Fetches the `Account` array for the user
	- Returns: An `[Account]` object
	*/
	public func getAccounts() -> [Account] {
		return self.accounts
	}
	
	/**
	Sets the users `Account` data
	- Parameter accounts: An `[Accounts]` object
	*/
	public func setAccounts(accounts: [Account]) {
		self.accounts = accounts
	}
	
	//MARK: -
}
