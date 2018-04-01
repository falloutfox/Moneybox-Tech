//
//  PaymentData.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 30/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import Foundation

///Struct for holding the payment data
struct PaymentData: Encodable {
	///The amount to add to the moneybox
	private(set) public var amount: Int = 0
	
	///The `investorProductId` from the `Account`
	private(set) public var investorProductId: Int = 0
	
	//Used to decode incoming JSON into the correct properties
	enum CodingKeys: String, CodingKey {
		case amount = "Amount"
		case investorProductId = "InvestorProductId"
	}
	
	/**
	Initalises the `PaymentData` struct
	- Parameters:
		- amount: The amount to add as an `Int`
		- investorProductId: The `investorProductId` from the `Account`
	*/
	init(amount: Int, investorProductId: Int) {
		self.amount = amount
		self.investorProductId = investorProductId
	}
}
