//
//  MyBaseListVC_Data.swift
//  MBaseTestBed
//
//  Created by mio on 2020/5/5.
//  Copyright © 2020 miochen. All rights reserved.
//

import UIKit
import MBaseSDK

class MyBaseListVC_Data: UIDataProvider {
    private var items:[dataMapObj] = []
    var showEmpty:Bool = true {
        didSet{
            self.notifyDataChange()
        }
    }
    
    func cleanItems() {
        items.removeAll()
        self.notifyDataChange()
    }
    
    func addItem(itemId: String, title: String, descript: String, imageUrl: String) {
        var data = dataMapObj.init()
        data["itemId"] = itemId
        data["labelTitle"] = title
        data["labelDescript"] = descript
        data["ivIcon"] = imageUrl
        self.items.append(data)
    }
    
    override init() {
        super.init()
        self.items.removeAll()
    }
    
    override func getTableData() -> [String : Any] {
        var secArray:[dataMapObj] = []
        var sec_1_node:dataMapObj = ["secName":""]
        sec_1_node["dataMap"] = []
        
        var cellArray:[dataMapObj] = []
        for item in self.items {
            var itemData = item
            itemData["nibName"] = "MyBaseListCell"
            cellArray.append(itemData)
        }
        
        if(self.showEmpty && self.items.count == 0) {
            var itemDataEmpty = dataMapObj()
            itemDataEmpty["nibName"] = "EmptyCell"
            itemDataEmpty["labelEmpty"] = "EMPTY"
            cellArray.append(itemDataEmpty)
        }
        
        sec_1_node["list"] = cellArray
        secArray.append(sec_1_node)
        
        var tableData:dataMapObj = [:]
        tableData["list"] = secArray
        return tableData
    }
}
