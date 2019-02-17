//
//  TableViewCell.swift
//  Coding Assignment Weather App
//
//  Created by Sanip Shrestha on 2/13/19.
//  Copyright © 2019 Learning. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var avgTemp: UILabel!
    @IBOutlet weak var city: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
