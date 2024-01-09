//
//  JAAuctionCell.swift
//  Jurassic
//
//  Created by Alan on 2019/8/31.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit
import MBaseSDK

class JAAuctionCell: BaseTableCell {

    @IBOutlet weak var tagBgView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
