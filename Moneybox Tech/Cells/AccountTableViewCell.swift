//
//  AccountTableViewCell.swift
//  Moneybox Tech
//
//  Created by Ollie Stowell on 30/03/2018.
//  Copyright © 2018 Oliver Stowell. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		self.layer.cornerRadius = 5
		self.layer.borderColor = UIColor.black.cgColor
		self.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
