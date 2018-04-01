//
//  Account.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 29/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import Foundation

///An object that holds the data needed for an account
class Account: Decodable {
	///The account Investor Product ID
	private(set) public var investorProductID: Int = 0
	
	///The account Product ID
	private(set) public var productId: Int = 0
	
	///The amount saved this week, aka the Moneybox
	private(set) public var moneybox: Float = 0
	
	///The account subscription amount
	private(set) public var subscriptionAmount: Float = 0
	
	///The account balance
	private(set) public var planValue: Float = 0
	
	///The amount contributed this tax year
	private(set) public var sytd: Float = 0
	
	///The amount transferred from another provider
	private(set) public var transferInSytd: Float = 0
	
	///The remaining amount that can be contributed
	private(set) public var maximumDeposit: Float = 0
	
	///The Product associtated with the account
	private(set) public var product: Product = Product()
	
	//Used to decode incoming JSON into the correct properties
	enum CodingKeys: String, CodingKey {
		case investorProductID = "InvestorProductId"
		case productId = "ProductId"
		case moneybox = "Moneybox"
		case subscriptionAmount = "SubscriptionAmount"
		case planValue = "PlanValue"
		case sytd = "Sytd"
		case transferInSytd = "TransferInSytd"
		case maximumDeposit = "MaximumDeposit"
		
		case product = "Product"
	}
	
	//MARK: - Moneybox Set
	
	/**
	Updates the `Moneybox` property
	- Warning: This should only be updated using the JSON response from the API
	- Parameter moneybox: A `Float` representing the latest value
	*/
	public func setMoneybox(moneybox: Float) {
		self.moneybox = moneybox
	}
	
	//MARK: -
}
