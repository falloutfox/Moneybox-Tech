//
//  Product.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 29/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import Foundation

///An object that holds the data needed for a product
class Product: Decodable {
	///The product name
	private(set) public var name: String = ""
	
	///The product type
	private(set) public var type: String = ""
	
	///The user friendly display name
	private(set) public var friendlyName: String = ""
	
	//Used to decode incoming JSON into the correct properties
	enum CodingKeys: String, CodingKey {
		case name = "Name"
		case type = "Type"
		case friendlyName = "FriendlyName"
	}
	
	//MARK: -
}
