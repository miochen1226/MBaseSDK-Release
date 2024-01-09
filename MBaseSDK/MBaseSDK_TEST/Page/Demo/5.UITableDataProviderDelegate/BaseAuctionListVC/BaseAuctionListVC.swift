//
//  BaseAuctionListVC.swift
//  Jurassic
//
//  Created by mio on 2020/7/23.
//  Copyright © 2020 mio. All rights reserved.
//

import UIKit
import MBaseSDK

extension BaseAuctionListVC: UITableDataProviderDelegate {
    func emptyCellData() -> dataMapObj {
        var itemDataEmpty = dataMapObj()
        itemDataEmpty["nibName"] = "AuctionEmptyWithCheckScheduleCell"
        itemDataEmpty["emptyInfo"] = "Bidding_Page_No_Data"
        itemDataEmpty["btnCheckSchedule"] = "registed_auction_item_check_schedule"
        return itemDataEmpty
    }
    
    func itemObjToCellData(data:Any?, nibName: String) -> dataMapObj {
        var dataMapObj:dataMapObj = data as? dataMapObj ?? [:]
        dataMapObj["nibName"] = nibName
        return dataMapObj
    }
}

class BaseAuctionListVC: BaseListVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataProvider = UITableDataProvider(delegate: self)
    }

    @objc override func refreshData() {
        self.doFetchListData()
    }

    override func doFetchListData() {
        for i in 1...20 {
            let auctionImage = "https://www.fate-sn.com/assets_hf3/img/special/countdown/HF3-countdown100_" + String(i) + ".jpg"
            
            let data =
                ["auctionStatus":"OPEN","auctionTitle":"TITLE_" + String(i),
                        "auctionDuration":"DURATION_" + String(i),
                        "auctionInfo":"INFO_" + String(i),
                        "auctionImage":auctionImage]
            self.tableDataProvider?.insertItem(itemId: String(i), data: data, nibName: "JAAuctionCell")
        }
        
        self.tableDataProvider?.notifyDataChange()
    }
}
