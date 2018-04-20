//
//  DataManager.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 30/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import UIKit

///Struct to hold the sandbox login details
struct UserData {
	static let email: String = "test+env12@moneyboxapp.com"
	static let password: String = "Money$$box@107"
}

///`Error` enum for the `DataManager` class
enum DataManagerError: Error {
	case noUserData
	case noSessionData
}

///An object that contains the data necessary for the app to function
class DataManager: NSObject {
	///The currently logged in user
	private var user: User?
	
	///The current API session
	private var session: Session?
	
	//MARK: - User Get/Set
	
	/**
	Fetches the `User` object, or returns an `DataManagerError` if the object is `nil`
	- Returns: A `User?` optional
	*/
	
	public func getUser() -> User? {
		return self.user
	}
	
	/**
	Sets the `User` object
	- Parameter user: The new `User` object to use
	*/
	public func setUser(user: User) {
		self.user = user
	}
	
	//MARK: - Session Get/Set
	
	/**
	Fetches the `Session` object, or returns an `DataManagerError` if the object is `nil`
	- Returns: A `(Session?, DataManagerError?)` tuple
	*/
	public func getSession() -> (session: Session?, error: DataManagerError?) {
		if self.session == nil {
			return (nil, .noSessionData)
		} else {
			return (self.session, nil)
		}
	}
	
	/**
	Sets the `Session` object
	- Parameter user: The new `Session` object to use
	*/
	public func setSession(session: Session) {
		self.session = session
	}
	
	//MARK: - Logout
	
	///Removes all user & session data
	public func logoutUser() {
		self.user = nil
		self.session = nil
	}
}
