//
//  Session.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 29/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import Foundation

///An object that holds the data needed to authorise a session
struct Session: Decodable {
	///The Bearer Token for authorising requests
	private(set) public var bearerToken: String = ""
	
	//Used to decode incoming JSON into the correct properties
	enum CodingKeys: String, CodingKey {
		case bearerToken = "BearerToken"
	}
	
	//MARK: -
}
