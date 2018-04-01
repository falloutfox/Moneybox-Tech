//
//  LoginData.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 30/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import Foundation
import AdSupport

//TODO: fail gracefully if cannot get idfa

///Struct for holding the user credentials
struct LoginData: Encodable {
	///The user's email
	private(set) public var email: String = ""
	
	///The user's password
	private(set) public var password: String = ""
	
	///The device's IDFA as a `String`
	private(set) public var idfa: String = ""
	
	//Used to decode incoming JSON into the correct properties
	enum CodingKeys: String, CodingKey {
		case email = "Email"
		case password = "Password"
		case idfa = "IDFA"
	}
	
	/**
	Initalises the `LoginData` struct
	- Parameters:
		- email: The user's email as a `String`
		- password: The user's password as a `String`
	*/
	init(email: String, password: String) {
		self.email = email
		self.password = password
		
		let idfa = getIDFA()
		
		if idfa != nil {
			self.idfa = idfa!
		}
	}
	
	/**
	Gets the IDFA for the current device
	- Returns: The IDFA as a `String`
	*/
	private func getIDFA() -> String? {
		guard ASIdentifierManager.shared().isAdvertisingTrackingEnabled else {
			return nil
		}
		
		return ASIdentifierManager.shared().advertisingIdentifier.uuidString
	}
}
