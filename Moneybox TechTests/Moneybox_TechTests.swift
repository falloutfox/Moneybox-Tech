//
//  Moneybox_TechTests.swift
//  Moneybox TechTests
//
//  Created by Ollie Stowell on 29/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import XCTest
@testable import Moneybox_Tech

//TODO: LoginData Test
//TODO: PaymentData Test
//TODO: Response subclass Test
//TODO: DataManager Tests ?
//TODO: APIManager Tests ?

class Moneybox_TechTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	func testUserDecode() {
		let userString: String =
		"""
		{
			"UserId": "74d21315-538e-4abc-a4a8-38cb0291216f",
			"HasVerifiedEmail": true,
			"IsPinSet": true,
			"RegistrationStatus": "IsComplete",
			"DateCreated": "2017-11-17T10:19:06.537",
			"MoneyboxRegistrationStatus": "IsComplete",
			"Email": "test+sample@moneyboxapp.com",
			"FirstName": "Sample",
			"LastName": "User",
		}
		"""
		
		let jsonData = userString.data(using: .utf8)!
		
		do {
			_ = try JSONDecoder().decode(User.self, from: jsonData)
			XCTAssert(true)
		} catch {
			print(error)
			XCTAssert(false)
		}
	}
	
	func testSessionDecode() {
		let sessionString =
		"""
		{
			"BearerToken": "Kcuf/DOjXgwDioE6wOdM1XyR/+ncwzdT0N9bJjl+O6g=",
			"ExternalSessionId": "0f1ae000-9eda-4f59-ad78-5773b9d71315",
			"SessionExternalId": "0f1ae000-9eda-4f59-ad78-5773b9d71315",
			"ExpiryInSeconds": 0
		}
		"""
		
		let jsonData = sessionString.data(using: .utf8)!
		
		do {
			_ = try JSONDecoder().decode(Session.self, from: jsonData)
			XCTAssert(true)
		} catch {
			print(error)
			XCTAssert(false)
		}
	}
	
	func testProductDecode() {
		let productString =
		"""
		{
			"Name": "ISA",
			"Type": "Isa",
			"AnnualLimit": 20000,
			"DepositLimit": 0,
			"FriendlyName": "Stocks & Shares ISA"
		}
		"""
		
		let jsonData = productString.data(using: .utf8)!
		
		do {
			_ = try JSONDecoder().decode(Product.self, from: jsonData)
			XCTAssert(true)
		} catch {
			XCTAssert(false)
		}
	}
	
	func testAccountDecode() {
		let accountString =
		"""
		{
			"InvestorProductId": 3229,
			"InvestorProductType": "Isa",
		    "ProductId": 1,
		    "Moneybox": 130,
		    "PreviousMoneybox": 130,
		    "SubscriptionAmount": 30,
		    "PlanValue": 5235,
		    "Sytd": 1235,
		    "TransferInSytd": 4000,
		    "MaximumWithdrawal": 0,
		    "MaximumDeposit": 14765,
		    "TotalContributions": 0,
		    "TotalReturnValue": 0,
		    "TotalReturnPercentage": 0,
		    "CashInTransit": 0,
		    "ResidualCash": 0,
		    "TotalFees": 0,
		    "TotalReturnValueGross": 0,
		    "PendingWithdrawal": 0,
		    "IsPendingRebalance": false,
		    "PendingDeposit": 0,
		    "Product": {
		        "Name": "ISA",
		        "Type": "Isa",
		        "AnnualLimit": 20000,
		        "DepositLimit": 0,
		        "FriendlyName": "Stocks & Shares ISA"
		    },
		    "DateModified": "2017-11-17T10:21:10.437",
		    "Valuations": [],
		    "IsSelected": true,
		    "IsFavourite": true
		}
		"""
		
		let jsonData = accountString.data(using: .utf8)!
		
		do {
			_ = try JSONDecoder().decode(Account.self, from: jsonData)
			XCTAssert(true)
		} catch {
			XCTAssert(false)
		}
	}
}
