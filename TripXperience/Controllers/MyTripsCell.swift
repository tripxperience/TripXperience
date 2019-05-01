//
//  MyTripsCell.swift
//  TripXperience
//
//  Created by Miguel Aceves on 4/10/19.
//  Copyright © 2019 tripxperience. All rights reserved.
//

import UIKit

class MyTripsCell: UITableViewCell {

    @IBOutlet weak var tripImage: UIImageView!
    @IBOutlet weak var titleTipField: UILabel!
    @IBOutlet weak var descriptionField: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
