//
//  DOTableViewCell.swift
//  MBaseSDK_TEST
//
//  Created by mio on 2020/12/28.
//

import UIKit
import MBaseSDK

class DOTableViewCell: BaseTableCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        //self.backgroundColor = .yellow
        //UIView.animate(withDuration: 10000, animations: {
            
            
            
        //}, completion: { _ in
        //    self.backgroundColor = .white
        //})
        
    }
}
