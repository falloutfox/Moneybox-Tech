//
//  AlertManager.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 01/04/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import UIKit

///Manager for shared alert objects
class AlertManager: NSObject {
	
	///No network alert
	public class func networkAlert(viewController: UIViewController) {
		let alert = UIAlertController(title: "Network Error",
									  message: "The Internet connection..",
									  preferredStyle: .alert)
		let settingsAction = UIAlertAction(title: "Settings",
										   style: .default)
		{ (_) in
			guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
				return
			}
			if UIApplication.shared.canOpenURL(settingsUrl) {
				UIApplication.shared.open(settingsUrl,
										  completionHandler: nil)
			}
		}
		let cancelAction = UIAlertAction(title: "Cancel",
										 style: .cancel,
										 handler: nil)
		alert.addAction(settingsAction)
		alert.addAction(cancelAction)
		
		viewController.present(alert,
							   animated: true,
							   completion: nil)
	}
	
	public class func bearerTokenExpired(viewController: UIViewController) {
		let alert = UIAlertController(title: "Logged Out",
									  message: "You've been logged out due to inactivity.",
									  preferredStyle: .alert)
		let action = UIAlertAction(title: "OK",
								   style: .default)
		{ (_) in
			DispatchQueue.main.async {
				DataManager.getInstance().logoutUser()
				viewController.navigationController?.popToRootViewController(animated: true)
			}
		}
		alert.addAction(action)
		
		viewController.present(alert,
							   animated: true,
							   completion: nil)
	}

}
