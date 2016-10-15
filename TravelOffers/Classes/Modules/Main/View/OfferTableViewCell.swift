//
//  OfferTableViewCell.swift
//  TravelOffers
//
//  Created by Rustam Yuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
