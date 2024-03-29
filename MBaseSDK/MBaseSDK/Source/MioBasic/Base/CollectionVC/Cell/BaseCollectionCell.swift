//
//  BaseCollectionCell.swift
//  MBaseSDK
//
//  Created by mio on 2019/4/1.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit
public protocol BaseCollectionCellDelegate : AnyObject {
    func didBaseCollectionCellButtonClicked(data: dataMapObj)
}

open class BaseCollectionCell: UICollectionViewCell, DFProtocal {
    open var dataMap: [String : Any] = [:]
    public weak var baseDelegate: BaseCollectionCellDelegate?
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        DataFillTool.checkAndFillData(self,dataMap:self.dataMap)
    }
}
