//
//  Response.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 30/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import Foundation

///Parses the `JSON` errors from the API
struct ErrorResponse: Decodable {
	///The error name
	var name: String = ""
	
	///The error message
	var message: String = ""
	
	//Used to decode incoming JSON into the correct properties
	enum CodingKeys: String, CodingKey {
		case name = "Name"
		case message = "Message"
	}
}

///Parses the `JSON` login response from the API
struct LoginResponse: Decodable {
	///The parsed `User`
	var user : User = User()
	
	///The parsed `Session`
	var session : Session = Session()
	
	//Used to decode incoming JSON into the correct properties
	enum CodingKeys: String, CodingKey {
		case user = "User"
		case session = "Session"
	}
}

///Parses the `JSON` accounts response from the API
struct AccountsResponse: Decodable {
	///The parsed accounts linked to the User
	var accounts: [Account] = []
	
	//Used to decode incoming JSON into the correct properties
	enum CodingKeys: String, CodingKey {
		case accounts = "Products"
	}
}

///Parses the `JSON` payment response from the API
struct PaymentResponse: Decodable {
	///The new value of the moneybox
	var moneybox: Float = 0
	
	//Used to decode incoming JSON into the correct properties
	enum CodingKeys: String, CodingKey {
		case moneybox = "Moneybox"
	}
}
