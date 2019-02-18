//
//  DetailedVCTableViewCell.swift
//  Coding Assignment Weather App
//
//  Created by Sanip Shrestha on 2/19/19.
//  Copyright © 2019 Learning. All rights reserved.
//

import UIKit

class DetailedVCTableViewCell: UITableViewCell {

    
    @IBOutlet weak var header: UILabel!
    
    @IBOutlet weak var information: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
