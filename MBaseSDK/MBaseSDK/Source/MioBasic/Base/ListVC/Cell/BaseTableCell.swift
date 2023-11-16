//
//  BaseTableCell.swift
//  jourdenessSPA
//
//  Created by mio on 2019/4/1.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit


public protocol BaseTableCellDelegate :AnyObject {
    func didBaseTableCellButtonClicked(data:dataMapObj)
}


open class BaseTableCell:UITableViewCell,DFProtocal {
    public weak var baseDelegate: BaseTableCellDelegate?
    open var dataMap: [String : Any] = [:]
    var sepratorHeight:Float = 10
    var cornerRadius:Float = 0

    @IBOutlet weak var sepratorHeightConstraint:NSLayoutConstraint!
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = CGFloat(self.cornerRadius)
        let myBackView = UIView.init(frame: self.frame)
        myBackView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = myBackView
        
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.sepratorHeightConstraint?.constant = CGFloat(sepratorHeight)
        DataFillTool.checkAndFillData(self,dataMap:self.dataMap)
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
