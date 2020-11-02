//
//  MBDirectoryCell.swift
//  MBaseTestBed
//
//  Created by mio on 2020/5/2.
//  Copyright © 2020 innoorz. All rights reserved.
//

import UIKit
class MBDirectoryCell: BaseTableCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let haveImplement = self.dataMap["haveImplement"] as? Bool ?? false
        if(haveImplement)
        {
            self.contentView.alpha = 1
        }
        else
        {
            self.contentView.alpha = 0.3
        }
        
    }
    
}
